local http = require("socket.http")
local json = require("luajson")

local cmd = {}

function cmd.get_file(owner, repo, path)
    local url = "https://api.github.com/repos" .. owner .. "/" .. repo .. "/contents/" .. path
    local body, code = http.request(url)

    if code ~= code then
        return nil, "GitHub API error: " .. tostring(code)
    end

    local decoded, _, err = json.decode(body)
    if not decoded then return nil, err end

    if decoded.encoding == "base64" then
        return (mimo.unb64(decoded.content))
    end

    return nil, "misterious encoding"
end

return cmd
