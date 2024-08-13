local player = require("player")
local map = require("map")
local objects = require("objects")
local tick = require("tick")

function love.load()
    -- Setting window size
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
        { img = love.graphics.newImage("/textures/wall_brick_01.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_brick_02.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_brick_03.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_magic_01.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_magic_02.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_metal_01.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_01.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_02.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_03.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_04.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_05.jpg"), size = 128 },
    }
    -- Floor/ceiling textures need to be loaded in as image data to use getPixel
    FLOOR_TEXTURES = {
        { img = love.image.newImageData("/textures/floor_brick_01.jpg"),    size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_01.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_02.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_03.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_04.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_05.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_06.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_07.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_concrete_08.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_grass_01.jpg"),    size = 128 },
        { img = love.image.newImageData("/textures/floor_metal_01.jpg"),    size = 128 },
        { img = love.image.newImageData("/textures/floor_metal_02.jpg"),    size = 128 },
        { img = love.image.newImageData("/textures/floor_stone_01.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_stone_02.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/floor_tile_01.jpg"),     size = 128 },
        { img = love.image.newImageData("/textures/floor_tile_02.jpg"),     size = 128 },
        { img = love.image.newImageData("/textures/floor_wood_01.jpg"),     size = 128 },
        { img = love.image.newImageData("/textures/wall_painted_01.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/wall_painted_02.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/wall_painted_03.jpg"), size = 128 },
        { img = love.image.newImageData("/textures/wall_painted_04.jpg"), size = 128 },
    }
    -- Sprites
    SPRITE_TEXTURES = {
        { img = love.graphics.newImage("/textures/sprite_barrel_01.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/sprite_lamp_01.jpg"),   size = 128 },
    }
    -- For limiting fps
    SLEEP = 0

    -- Game objects
    OBJ = {}
    table.insert(OBJ, objects:create_obj("barrel", 2, 2, 1))
    table.insert(OBJ, objects:create_obj("barrel", 3, 2, 1))
    table.insert(OBJ, objects:create_obj("barrel", 4.5, 2, 1))
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

    map:raycasting(player, OBJ)

    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
