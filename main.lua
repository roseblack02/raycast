local Player = require("player")
local Raycaster = require("raycast-tiled")
local Map = require("map-tiled")
local Objects = require("objects")
local Tick = require("tick")
local Push = require("push")

-- Window settings
local screen_width, screen_height = 640, 480
local window_width, window_height = 800, 600 --love.window.getDesktopDimensions()
Push:setupScreen(screen_width, screen_height, window_width, window_height, { fullscreen = false })

function love.load()
    Map:init_map('/maps/test-map/','test-map')
    Map:load_objs(Objects)
    Player.x=3
    Player.y=3
end

function love.update(dt)
    -- Framerate cap
    Tick.framerate = 31

    Player:update(Map)
end

function love.draw()
    -- For window sizing
    Push:start()

    love.graphics.clear(0, 0, 0)
    Raycaster:raycasting(Player, Map, screen_width, screen_height)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)

    Push:finish()
end
