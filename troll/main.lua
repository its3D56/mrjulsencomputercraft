local mod = {}

print("Running program from github...")
io.write("Input tne direction the turtle is facing: ")
io.flush()

function mod.main()
  while true do
    local sound = sounds[math.random(1, #sounds)]
    speaker.playSound(sound, 0.1)
    local timeout = math.random(5, 10)
    print("Next sound in: " .. timeout .. "s")
    os.sleep(timeout)
  end
end

speaker = peripheral.find("speaker")

sounds = {
  "entity.creeper.primed",
  "entity.ender_dragon.growl",
  -- "entity.enderman.death",
  "entity.wolf.death",
}

function playFile(name)
  local buffer = {}
  
end

return mod
