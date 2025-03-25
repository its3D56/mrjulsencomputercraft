os.sleep(10) -- Wait for chunks with peripherals to load in fully

local mod = {}

hall9000 = wrequire "hall9000"

local modules = {
  wrequire "induction_matrix",
  wrequire "arc_furnaces",
  wrequire "digital_miner"
}

local monitor = peripheral.find("monitor")

function mod.main()
  hall9000.init()
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

-- Adds padding at the end of text to make it a certain size
function pad(text, size)
  local len = text:len()
  if len >= size then
    return text
  end
  return text .. string.rep(" ", size - len)
end

local narrator_speaker = peripheral.wrap("speaker_block_0")
local chat_speaker = peripheral.wrap("speaker_block_1")

function speaker_setup()
  narrator_speaker.setVolume(speaker_volume)
  narrator_speaker.setName(" ")
  chat_speaker.setVolume(speaker_volume)
  chat_speaker.setName(speaker_name)
end

return mod
