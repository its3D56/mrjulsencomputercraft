local config = {
  name = "Hall9000",
  speaker_volume = 64,
}

local lines = wrequire "lines"

local narrator_speaker = peripheral.wrap("speaker_block_0")
local chat_speaker = peripheral.wrap("speaker_block_1")

local mod = {}

function mod.init()
  
end

function mod.trigger_event(event_name)

end

function say(message)

end

local api = {
  w = say
}
