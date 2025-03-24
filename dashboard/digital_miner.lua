local mod = {}

local timer = 0

local miner_running = false
local mining_results = {}
local item_order = {}

local buffer_barrel = peripheral.wrap "minecraft:barrel_1"
local entangloporter = peripheral.wrap "quantumEntangloporter_0"
local diverter = peripheral.wrap "diversionTransporter_0"

function init()
  enable_output(false)
  enable_input(true)
end

function mod.update()
  local buffer_empty = check_buffer_empty()

  if not buffer_empty and not miner_running then
    miner_running = true
    mining_results = {}
    item_order = {}
  end
  
  if not miner_running then return end

  if buffer_empty then
    miner_running = false
    hal9000.trigger_event "mining_complete"
    return
  end
  
  if timer == 0 then
    enable_output(false)
    enable_input(true)
  elseif timer >= 2 then
    enable_input(false)
    log_contents()
    enable_output(true)
  elseif timer >= 6 then
    timer = 0
    return
  end
  timer = timer + 0.5
end

function mod.display(monitor)
  monitor.writeLine("DIGITAL MINERS:")
  if miner_running then
    monitor.writeLine("  Miners Active")
  else
    monitor.writeLine("  Miners Inactive")
  end
  monitor.writeLine("  Mining Results:")
  for _, name in ipairs(item_order) do
    item = mining_results[name]
    monitor.writeLine("  - " .. item.count .. "x " .. item.display_name)
  end
end

function check_buffer_empty()
  local contents = buffer_barrel.list()
  for _, _ in pairs(contents) do
    return false
  end
  return true
end

function log_contents()
  local contents = buffer_barrel.list()
  for location, _ in pairs(contents) do
    add_to_log(buffer_barrel.getItemDetail(location))
  end
end

function add_to_log(item)
  local res = {}
  if not contains(item_order, item.name) then
    table.insert(item_order, item.name)
  end

  local prev_count = (mining_results[item.name] or {count = 0}).count
  
  res.display_name = item.displayName
  res.count = item.count + prev_count

  mining_results[item.name] = res
end

function contains(input_table, element)
  for _, e in pairs(input_table) do
    if e == element then return true end
  end
  return false
end

function enable_output(enabled)
  if enabled then
    diverter.setMode("south", "DISABLED")
  else
    diverter.setMode("south", "HIGH")
  end
end

function enable_input(enabled)
  entangloporter.setEjecting("ITEM", enabled)
end

init()

return mod
