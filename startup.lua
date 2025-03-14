local mod

print("loaded file from github!")
speaker = peripheral.find("speaker")

while true do
  speaker.playSound("entity.creeper.primed")
  turtle.forward()
end

