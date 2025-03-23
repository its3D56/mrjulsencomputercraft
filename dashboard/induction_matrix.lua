local im = peripheral.find("inductionPort", function(name, _)
  return name == "inductionPort_0"
end)

function display(monitor)
  local stored_power = j_to_fe(im.getEnergy())
  local capacity = j_to_fe(im.getMaxEnergy())
  local stored_percentage = math.round(stored_power / capacity * 100)
  local input = j_to_fe(im.getLastInput())
  local output = j_to_fe(im.getLastOutput())
  local transfer_cap = j_to_fe(im.getTransferCap())
  monitor.writeLine("INDUCTION MATRIX:")
  monitor.writeline("  Stored power: " .. stored_power .. "FE / " .. capacity .. "FE ")
  monitor.writeline("  I/O: " .. input .. "FE/t / " .. output .. "FE/t" .. " Cap: " .. transfer_cap .. "FE/t")
end

function j_to_fe(j)
  return j * 0.4
end

return display
