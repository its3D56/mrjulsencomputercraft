local mod = {}

local im = peripheral.find("inductionPort", function(name, _)
  return name == "inductionPort_0"
end)

function mod.display(monitor)
  
end

return mod
