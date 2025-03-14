local mod

print("Running program from github...")

speaker = peripheral.find("speaker")

sounds = {
  "entity.creeper.primed",
  "entity.ender_dragon.growl",
  -- "entity.enderman.death",
  "entity.wolf.death",
}

while true do
  local sound = sounds[math.random(1, #sounds)]
  speaker.playSound(sound, 0.1)
  local timeout = math.random(5, 10)
  print("Next sound in: " .. timeout .. "s")
  os.sleep(timeout)
end

