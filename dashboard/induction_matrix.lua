local mod = {}

local im = peripheral.wrap "inductionPort_0"

function mod.update()
  print("gdoigus")
  stored_power = format_joules(im.getEnergy())
  capacity = format_joules(im.getMaxEnergy())
  stored_percentage = im.getEnergyFilledPercentage() * 100
  input = format_joules(im.getLastInput())
  output = format_joules(im.getLastOutput())
  transfer_cap = format_joules(im.getTransferCap())
end

function mod.display(monitor)
  monitor.writeLine("INDUCTION MATRIX:")
  monitor.writeLine("  Stored Power: " .. stored_power .. "FE (" .. stored_percentage .. "%)")
  monitor.writeLine("  Capacity:     " .. capacity .. "FE")
  monitor.writeLine("  Input:        " .. input .. "FE/t")
  monitor.writeLine("  Output:       " .. output .. "FE/t")
  monitor.writeLine("  Transfer Cap: " .. transfer_cap .. "FE/t")
end

function format_joules(j)
  return format_number(j * 0.4)
end

return mod
