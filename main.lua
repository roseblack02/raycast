local player = require("player")
local raycaster = require("raycast")
local map = require("map")
local objects = require("objects")
local tick = require("tick")

function love.load()
    -- Window settings
    SCREEN_WIDTH, SCREEN_HEIGHT = 800, 600
    love.window.setMode(SCREEN_WIDTH, SCREEN_HEIGHT, {
        vsync = 1,
        resizable = false,
        centered = true,
    })
    SCALE = { x = 1, y = 1 }

    -- Load texture data
    -- Wall textures need to be loaded in using graphics to use quads
    WALL_TEXTURES = { -- {texture,size}
        { img = love.graphics.newImage("/textures/walls/wall_brick_01.png"),      size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_02.png"),      size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_03.png"),      size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_01.png"), size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_02.png"), size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_03.png"), size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_04.png"), size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_05.png"), size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_06.png"), size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_magic_01.png"),      size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_magic_02.png"),      size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_metal_01.png"),      size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_painted_01.png"),    size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_painted_02.png"),    size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_painted_03.png"),    size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_painted_04.png"),    size = 128 },
        { img = love.graphics.newImage("/textures/walls/wall_painted_05.png"),    size = 128 },
    }
    -- Floor/ceiling textures need to be loaded in as image data to use getPixel
    FLOOR_TEXTURES = {
        { img = love.image.newImageData("/textures/floors/floor_brick_01.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_01.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_02.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_03.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_04.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_05.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_06.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_07.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_concrete_08.png"), size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_grass_01.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_magic_01.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_magic_02.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_metal_01.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_metal_02.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_painted_01.png"),  size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_stone_01.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_stone_02.png"),    size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_tile_01.png"),     size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_tile_02.png"),     size = 128 },
        { img = love.image.newImageData("/textures/floors/floor_wood_01.png"),     size = 128 },
    }
    SPRITE_TEXTURES = {
        { img = love.graphics.newImage("/textures/sprites/sprite_barrel_01.png"), size = 128 },
        { img = love.graphics.newImage("/textures/sprites/sprite_lamp_01.png"),   size = 128 },
    }
    SKYBOX_TEXTURES = {
        { img = love.graphics.newImage("/textures/skybox/sky_night_01.png"), width = 512, height = 128 },
    }
    -- For limiting fps
    SLEEP = 0

    -- Game objects
    OBJ = {}
    -- name, y, x, texture
    table.insert(OBJ, objects:create_obj("barrel", 2, 15, 1))
    table.insert(OBJ, objects:create_obj("barrel", 3, 15, 1))
    table.insert(OBJ, objects:create_obj("barrel", 4.5, 15, 1))
    table.insert(OBJ, objects:create_obj("lamp_post", 15, 3, 2))
    table.insert(OBJ, objects:create_obj("lamp_post", 11, 8, 2))
    table.insert(OBJ, objects:create_obj("lamp_post", 15, 14, 2))
end

function love.update(dt)
    tick.framerate = 31

    player:update(map)
end

function love.resize(w, h)
    -- Update scale
    SCALE.x = w / SCREEN_WIDTH
    SCALE.y = h / SCREEN_HEIGHT
end

function love.draw()
    love.graphics.clear(0, 0, 0)

    -- Make sure everything is scaled to current resolution
    love.graphics.scale(SCALE.x, SCALE.y)

    raycaster:raycasting(player, OBJ, map)

    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
