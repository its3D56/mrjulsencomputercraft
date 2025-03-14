local mod

print("loaded file from github!")
speaker = peripheral.find("speaker")

sounds = {
  "entity.creeper.primed",
  "entity.ender_dragon.roar",
  "entity.enderman.death",
  "entity.wolf.death",
}

while true do
  local sound = sounds[math.random(1, #sounds)]
  speaker.playSound(sound)
  os.sleep(math.random(1, 10))
end

