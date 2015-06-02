gl.setup(1024, 768)

local json = require "json"
local font = resource.load_font("dlrg-univers.ttf")
local inspect = require "inspect"

local images = util.auto_loader()

local time = '00:00'
local temperatures = {}

node.alias "infodisplay"

util.data_mapper{
    timer = function ( data )
        time = data
    end,
    temp = function ( data )
        temperatures = json.decode(data)
    end
}

function node.render(  )
    -- Hintergrund in weiß
    gl.clear(1,1,1,1)

    writeTimeAndTemperature()

    -- aktuelle Infos
    tWidth = font:width("Aktuelle Informationen", 75)
    font:write((WIDTH / 2) - (tWidth / 2), 55, "Aktuelle Informationen", 75, 0,0,0,1)

    pp(CONTENTS)
end

local function writeTimeAndTemperature(  )
    -- Temperaturen
    if temperatures.l ~= nil then
        local string = string.format("Luft: %.1f °C", temperatures.l)
        font:write(0, 0, string, 50, 0,0,0,1)
    end
    if temperatures.w ~= nil then
        local string = string.format("Wasser: %.1f °C", temperatures.w)
        local tWidth = font:width(string, 50)
        font:write(WIDTH - tWidth, 0, string, 50, 0,0,0,1)
    end

    -- Uhrzeit
    local tWidth = font:width(time, 50)
    font:write((WIDTH / 2) - (tWidth / 2), 0, time, 50, 0,0,0,1)
end
