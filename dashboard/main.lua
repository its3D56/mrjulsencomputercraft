local mod = {}

local induction_matrix, err = wrequire "induction_matrix"
local arc_furnaces = wrequire "arc_furnaces"

local modules = {
  induction_matrix
}

print(err)

local monitor = peripheral.find("monitor")
print(monitor)

function mod.main()
  while loop() do end
end

function loop()
  for _, module in ipairs(modules) do
    module.update()
  end

  monitor.clear()
  monitor.setCursorPos(1, 1)
  for _, module in ipairs(modules) do
    module.display(monitor)
    monitor.newlineCursor()
  end
  
  os.sleep(0.5)
  return true
end

-- Moves cursor to first character of new line
function monitor.newlineCursor()
  local _, cy = monitor.getCursorPos()
  monitor.setCursorPos(1, cy + 1)
end

-- Writes text and moves cursor to first character of new line
function monitor.writeLine(text)
  monitor.write(text)
  monitor.newlineCursor()
end

-- Fills rest of line with set character
function monitor.fillLine(filler)
  local width, _ = monitor.getSize()
  local cursor_x, _ = monitor.getCursorPos()
  local fill = filler:rep((width - cursor_x) / filler.len())
  monitor.write(fill)
end

return mod
