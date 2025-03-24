local src_url_f, err = fs.open("src_url.txt", "r")
if err then
  error("Failed to get source url" .. err)
  return
end
local src_url = src_url_f.readAll():sub(1, -2)
if not src_url then
  error("Failed to get url from file")
  return
end
src_url_f.close()
src_url_f = nil

function wrequire(path)
  local module = wload(path, _ENV)
  return module()
end

function wload(path, env)
  local src_req, err = http.get(src_url .. path .. ".lua")
  if err then
    error("Error getting file \"" .. path .. ".lua\": " .. err, 2)
    return nil
  end
  local src = src_req.readAll()
  src_req.close()
  local module, err = load(src, path .. ".lua", "t", env)
  if err then
    error("Error loading file \"" .. path .. ".lua\": " .. err, 2)
    return
  end
  return module
end

local main_mod = wrequire "main"

print("Module loaded successfully")
return main_mod.main()
