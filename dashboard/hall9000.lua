local config = {
  name = "Hall9000",
  speaker_volume = 64,
}

local mod = {}

local dialogue
local interface = {}

local narrator_speaker = peripheral.wrap("speaker_block_0")
local chat_speaker = peripheral.wrap("speaker_block_1")

function mod.init()  
  init_speakers()
  dialogue = wload("dialogue", interface)()
  mod.trigger_event("startup")
end

function mod.trigger_event(event_name, ...)
  local handler = dialogue[event_name]
  if not handler then
    print("Hall9000 WARN: No handler for \"" .. event_name .. "\"")
    return
  end
  handler(...)
end

function init_speakers()
  local name = config.name
  local volume = config.speaker_volume
  
  narrator_speaker.setVolume(volume)
  narrator_speaker.setName(" ")

  chat_speaker.setVolume(volume)
  chat_speaker.setName(name)
end

interface.time = os.time

function interface.say(message)
  narrator_speaker.setMessage(message)
  chat_speaker.setMessage(message)

  narrator_speaker.activate()
  chat_seaker.activate()
  print(config.name .. ": " .. message)
end

function interface.pick(options)
  local len = #options
  if not len > 0 then return end
  return options[math.floor(math.rand(1, len))]
end

function interface.fmt_time(locale)
  
end

function interface.log(message)
  print("Hall9000 LOG: " .. message)
end

return mod
