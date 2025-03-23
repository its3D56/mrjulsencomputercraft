local mod = {}

local induction_matrix, err = wrequire "induction_matrix"
local arc_furnaces = wrequire "arc_furnaces"

local modules = {
  arc_furnace,
  induction_matrix,
}

print(induction_matrix)

local monitor = peripheral.find("monitor")

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

-- SRC: https://stackoverflow.com/questions/10989788/format-integer-in-lua
function format_number(number)

  local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

  -- reverse the int-string and append a comma to all blocks of 3 digits
  int = int:reverse():gsub("(%d%d%d)", "%1,")

  -- reverse the int-string back remove an optional comma and put the 
  -- optional minus and fractional part back
  return minus .. int:reverse():gsub("^,", "") .. fraction
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
