require("player")
require("map")
require("functions")

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
    TEXTURES = { -- {texture,size}
        { img = love.graphics.newImage("/textures/wall_brick_01.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_brick_02.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_brick_03.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_magic_01.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_metal_01.jpg"),   size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_01.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_02.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_03.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_04.jpg"), size = 128 },
        { img = love.graphics.newImage("/textures/wall_painted_05.jpg"), size = 128 },
    }
    for _, texture in ipairs(TEXTURES) do
        texture.img:setFilter("nearest", "nearest", 8)
    end

    -- For limiting fps
    SLEEP = 0
end

function love.update(dt)
    -- Limit to 30 fps
    love.timer.sleep(SLEEP)

    if love.timer.getFPS() > 32 then
        SLEEP = SLEEP + 0.0001
    end

    PLAYER:update(MAP, dt)
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

    MAP:draw_fp(PLAYER)

    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end
