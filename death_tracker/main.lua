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
    -- death_counts = read_death_counts()
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
  monitor.setCursorPos(1, 1)
  for name, death_count in pairs(death_counts) do
    print(name .. "    " .. death_count)
    monitor.write(name .. "    " .. death_count .. "\n")
  end
end

function write_death_counts(death_counts)

end

function read_death_counts()

end

while main() do end
