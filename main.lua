local mod

print("loaded file from github!")
speaker = peripheral.find("speaker")

while true do
  speaker.playSound("entity.creeper.primed")
  os.sleep(math.random(1, 10))
end

