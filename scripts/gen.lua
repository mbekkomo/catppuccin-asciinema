#!/usr/bin/env lua
local cp = require("catppuccin")
local pretty_encode = require("resty.prettycjson") -- luarocks install lua-resty-prettycjson

if not cp[arg[1]] then
    io.stderr:write(("error: invalid flavor at arg #1: '%s'\n"):format(arg[1] or ""))
    os.exit(1)
end

local flavor = {}
for k, v in pairs(cp[arg[1]]()) do
    flavor[k] = v.hex
end

local theme_json = {
    fg = flavor.text,
    bg = flavor.base,
    palette = table.concat({
        arg[1] == "latte" and flavor.subtext1 or flavor.surface1,
        flavor.red,
        flavor.green,
        flavor.yellow,
        flavor.blue,
        flavor.pink,
        flavor.teal,
        arg[1] == "latte" and flavor.surface2 or flavor.subtext1,
        arg[1] == "latte" and flavor.subtext0 or flavor.surface2,
        flavor.red,
        flavor.green,
        flavor.yellow,
        flavor.blue,
        flavor.pink,
        flavor.teal,
        arg[1] == "latte" and flavor.surface1 or flavor.subtext0,
    }, ":"),
}

local f = assert(io.open("src/" .. arg[1] .. ".json", "w+"))
f:write(pretty_encode(theme_json, nil, (" "):rep(4)))
f:close()
