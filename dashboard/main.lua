local mod = {}

local induction_matrix = wrequire "induction_matrix"
local arc_furnaces = wrequire "arc_furnaces"

local monitor = peripheral.find("monitor")

function mod.main()
  while loop() do end
end

function loop()
  monitor.clear()
  monitor.setCursorPos(1, 1)
  induction_matrix.display(monitor)
  monitor.moveCursor(0, 1)
  arc_furnaces.display(monitor)
  monitor.moveCursor(0, 1)
  return true
end

function monitor.moveCursor(x, y)
  local cx, cy = monitor.getCursorPos()
  monitor.setCursorPos(cx + x, cy + y)
end

return mod
