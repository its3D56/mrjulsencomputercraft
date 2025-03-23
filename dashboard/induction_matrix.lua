local mod = {}
local im = peripheral.find("inductionPort", function(name, _)
  return name == "inductionPort_0"
end)

function mod.update()
  stored_power = format_joules(im.getEnergy())
  capacity = format_joules(im.getMaxEnergy())
  stored_percentage = im.getEnergyFilledPercentage()
  input = format_joules(im.getLastInput())
  output = format_joules(im.getLastOutput())
  transfer_cap = format_joules(im.getTransferCap())
end

function mod.display(monitor)
  monitor.writeLine("INDUCTION MATRIX:")
  monitor.writeLine("  Stored power: " .. stored_power .. "FE / " .. capacity .. "FE (" .. stored_percentage .. "%)")
  monitor.writeLine("  I/O: " .. input .. "FE/t / " .. output .. "FE/t" .. " Cap: " .. transfer_cap .. "FE/t")
end

function format_joules(j)
  return format_number(j * 0.4)
end

return mod
