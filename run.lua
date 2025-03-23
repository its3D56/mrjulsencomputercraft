local src_url_f, err = fs.open("src_url.txt", "r")
if err then
  error(err)
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
  local src_req, err = http.get(src_url .. path .. ".lua")
  if err then
    return nil, err
  end
  local src = src_req.readAll()
  local module, err = load(src, "", "t", _ENV)
  if err then
    return nil, err
  end
  return module()
end

local main_mod, err = wrequire "main"
if err then
  error(err)
  return
end

print("Module loaded successfully")
return main_mod.main()
