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
    draw_furnace_status(furnace, i)
  end
end

function draw_furnace_status(status, number)
  monitor.writeLine("#" .. number .. ": " .. status.activity .. " Electrodes: " .. status.electrodes)
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
      electrodes[i] = "None"
      continue
    end
    electrodes[i] = ((1 - electrode.damage / electrode.maxDamage) * 100) .. "%"
  end
  status.electrodes = electrodes.1 .. " " .. electrodes.2 .. " " .. electrodes.3

  return status
end

return mod
