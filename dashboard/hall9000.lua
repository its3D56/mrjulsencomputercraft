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
  dialogue = wload("dialogue", interface)
  mod.trigger_event("startup")
end

function mod.trigger_event(event_name, ...)
  local handler = dialogue[event_name]
  if not handler then return end
  handler(...)
end

function init_speakers()
  local name = config.name
  local voume = config.volume
  
  narrator_speaker.setVolume(speaker_volume)
  narrator_speaker.setName(" ")

  chat_speaker.setVolume(speaker_volume)
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

function interface.fmt_time(locale)
  
end

return mod
