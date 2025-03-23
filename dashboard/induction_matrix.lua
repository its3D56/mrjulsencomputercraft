local mod = {}
local im = peripheral.find("inductionPort", function(name, _)
  return name == "inductionPort_0"
end)

function mod.update()
  stored_power = j_to_fe(im.getEnergy())
  capacity = j_to_fe(im.getMaxEnergy())
  stored_percentage = math.floor(stored_power / capacity * 1000) / 10
  input = j_to_fe(im.getLastInput())
  output = j_to_fe(im.getLastOutput())
  transfer_cap = j_to_fe(im.getTransferCap())
end

function mod.display(monitor)
  monitor.writeLine("INDUCTION MATRIX:")
  monitor.writeLine("  Stored power: " .. stored_power .. "FE / " .. capacity .. "FE (" .. stored_percentage .. "%)")
  monitor.writeLine("  I/O: " .. input .. "FE/t / " .. output .. "FE/t" .. " Cap: " .. transfer_cap .. "FE/t")
end

function j_to_fe(j)
  return j * 0.4
end

return mod
