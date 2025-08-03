local cmd = arg[1]
table.remove(arg, 1)

if cmd == "install" then
    require("src.installer").install(arg[1])
elseif cmd == "list" then
    require("src.installer").list()
elseif cmd == "help" then
    print("lua lpm.lua <command> [args]")
    print("command list: install, list, help, more to come...")
else
    print("unknown command:", cmd)
end
