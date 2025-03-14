local mod

print("loaded file from github!")
speaker = peripherals.find("speaker")

while true do
  speaker.playSound("minecraft:entity.player.hurt")
  turtle.forward()
end

