local events = {}

function events.startup()
  log "Starting..."
end

function events.low_power()
  say "You are low on power."
end

function events.mining_complete()
  say "Your digital miners have finished mining."
end

return events
