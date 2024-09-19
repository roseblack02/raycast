-- main.lua (level editor)

-- grid and tile size
local tileSize = 128 / 2
local grid = {}

-- cam pos and speed
local camX, camY = 0, 0 
local camSpeed = 200

-- ui stuff
local selectedType = 1 -- default wall type
local wallTypes = {'brick', 'wood', 'stone brick', 'fence'}

-- encapsulation for tile properties :) 
function getTile(x,y)
    if not grid[y] then grid[y] = {} end
    return grid[y][x] or 0
end

function setTile(x,y, value)
    if not grid[y] then grid[y] = {} end
    grid[y][x] = value
end

function love.load()
    -- level editor window
    love.window.setTitle("Level Editor")
    love.window.setMode(1200, 500)
end

function love.draw()

    local gridAreaWidth = 900

    -- calc visible grid area based on camera position
    local startX = math.floor(camX / tileSize) - 1
    local startY = math.floor(camY / tileSize) - 1
    local endX = startX + math.ceil(gridAreaWidth / tileSize) + 1
    local endY = startY + math.ceil(love.graphics.getHeight() / tileSize) + 1

    -- draw grid
    for y = startY, endY do
        for x = startX, endX do
            local tile = getTile(x, y)

            if tile == 1 then
                love.graphics.setColor(1, 1, 1) -- Wall
            else
                love.graphics.setColor(0.3, 0.3, 0.3) -- Empty
            end

            -- convert grid coordinates to screen coordinates
            local screenX = (x * tileSize) - camX
            local screenY = (y * tileSize) - camY
            if screenX < gridAreaWidth then 
                love.graphics.rectangle("fill", screenX, screenY, tileSize, tileSize)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", screenX, screenY, tileSize, tileSize)
            end
        end
    end

    -- options ui panel (stole this shit from gpt i have no idea)
    love.graphics.setColor(0.2, 0.2, 0.2) 
    love.graphics.rectangle("fill", gridAreaWidth, 0, 300, love.graphics.getHeight()) -- Panel size

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Level Editor :)", 10, 10)
end

function love.update(dt)
    -- move the cam with WASD or arrow keys
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        camX = camX - camSpeed * dt
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        camX = camX + camSpeed * dt
    end
    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        camY = camY - camSpeed * dt
    end
    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        camY = camY + camSpeed * dt
    end
end

function love.mousepressed(x, y, button)
    local gridAreaWidth = 900

    if x < gridAreaWidth then
        -- clicked inside the grid area
        local gridX = math.floor((x + camX) / tileSize)
        local gridY = math.floor((y + camY) / tileSize)

        if button == 1 then
            setTile(gridX, gridY, selectedType)
        elseif button == 2 then
            setTile(gridX, gridY, 0)  -- right click to remove wall
        end
    end
end
