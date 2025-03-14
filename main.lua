local mod

print("loaded file from github!")
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
  os.sleep(math.random(60, 6000))
end

