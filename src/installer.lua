local github = require("src.github")
local lfs = require("lfs")

local cmd = {}

function cmd.install(repo)
    local owner, name = repo:match("([^/]+)/([^/]+)")
    if not owner or not name then
        print("invalid repository format")
        return
    end

    print("downloading package structure")
    local content, err = github.get_file(owner, name, "pkg.lua")
    if not content then
        print("Error:", err)
        return
    end

    local path = os.getenv("HOME") .. "/.lpm/packages/" .. name
    os.execute("mkdir -p " .. path)
    local file = io.open(path .. "/pkg.lua", "w")
    file:write(content)
    file:close()

    print("installation complete of", name, "to", path)
end

function cmd.list()
    local path = os.getenv("HOME") .. "/.lpm/packages/"
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            print(file)
        end
    end
end

return cmd
