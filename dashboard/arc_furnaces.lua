local mod = {}

local arc_furnaces = {
  peripheral.wrap "arc_furnace_1",
  peripheral.wrap "arc_furnace_2",
  peripheral.wrap "arc_furnace_3",
}

local statuses = {}

function mod.update()
  for i, furnace in ipairs(arc_furnaces) do
    statuses[i] = get_furnace_status(furnace)
  end
end

function mod.display(monitor)
  monitor.writeLine("ARC FURNACES:")    
  for i, furnace in ipairs(statuses) do
    monitor.writeLine(format_furnace_status(furnace, i))
  end
end

function format_furnace_status(status, number)
  return "  #" .. number .. ": " .. status.activity .. " Electrodes: " .. status.electrodes
end

function get_furnace_status(furnace)
  local status = {}
  
  if furnace.isRunning() then
    status.activity = "Running"
  else
    status.activity = "Idle   "
  end

  local electrodes = {}
  for i = 1, furnace.getElectrodeSlotCount() do
    local electrode = furnace.getElectrodeStack(i)
    if electrode.name ~= "immersiveengineering:graphite_electrode" then
      electrodes[i] = "Broken"
    else
      electrodes[i] = format_damage(electrode.damage / electrode.maxDamage)
    end
  end
  status.electrodes = electrodes[1] .. " " .. electrodes[2] .. " " .. electrodes[3]

  return status
end

function format_damage(fraction)
  local formatted = math.floor((1 - fraction) * 1000) / 10 .. "%"
  print(formatted)
  local padding = rep(" ", 6 - formatted:len())
  return formatted .. padding
end

return mod
