local mod

print("loaded file from github!")
speaker = peripheral.find("speaker")

while true do
  speaker.playSound("minecraft:entity.player.hurt")
  turtle.forward()
end

