local strings = require "cc.strings"

local anchor_dl = peripheral.find("create_target")
local monitor = peripheral.find("monitor")

if not (anchor_dl or monitor) then
  error("Could not find peripherals")
end

function main()
  local death_counts = {}

  local iterations = 0
  update_death_counts(death_counts)
  display_death_counts(death_counts)

  if iterations % 150 == 0 then
    write_death_counts(death_counts)
    death_counts = read_death_counts()
  end

  iterations = iterations + 1
  os.sleep(15)
  return true
end

function update_death_counts(death_counts)
  for i = 1, 24 do
    local line = anchor_dl.getLine(i)
    
    if string.sub(line, 1, 1) == " " then break end
    
    local name, deathcount = parse_line(line)
    death_counts[name] = deathcount
  end
end

function parse_line(ln)
  local name_end = string.find(ln, " ")  
  local name = string.sub(ln, 1, name_end - 1)
  local death_count = tonumber(string.sub(ln, name_end, -1))
  return name, death_count
end

function display_death_counts(death_counts)
  monitor.clear()
  local width, _ = monitor.getSize()
  local line_num = 2
  local spacing = 24
  monitor.setCursorPos(1, 1)
  monitor.setBackgroundColour(colours.black)
  monitor.write("USERNAME" .. string.rep(" ", width - 14) .."DEATHS")
  for name, death_count in pairs(death_counts) do
    if line_num % 2 == 0 then
      monitor.setBackgroundColour(colours.grey)
    else
      monitor.setBackgroundColour(colours.lightGrey)
    end
    monitor.setCursorPos(1, line_num)
    local padding = string.rep(" ", spacing - name:len() - 1)
    monitor.write(name .. padding .. death_count .. string.rep(" ", width))
    line_num = line_num + 1
  end
end

function write_death_counts(death_counts)
  local f = fs.open("death_counts.json", "w")
  local json = textutils.serializeJSON(death_counts)
  f.write(json)
  f.close()
end

function read_death_counts()
  local f = fs.open("death_counts.json", "r")
  local json = f.readAll()
  f.close()
  return textutils.unserializeJSON(json)
end

while main() do end
