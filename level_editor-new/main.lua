-- main.lua (level editor)

-- grid and tile size
local tileSize = 128 / 2
local grid = {}

-- cam pos and speed
local camX, camY = 0, 0 
local camSpeed = 200

-- ui stuff
local selectedType = 1 -- default wall type
local textureScroll = 0 -- current scroll offset for textures
local maxTexturesOnScreen = 10 -- Maximum number of textures visible without scrolling

-- Mouse state for drag scroll
local isDraggingScroll = false
local dragStartY = 0

-- Wall types and their corresponding texture filenames
local wallTextures = {
    "wall_brick_01.png",
    "wall_brick_02.png",
    "wall_brick_03.png",
    "wall_brick_door_01.png",
    "wall_brick_door_02.png",
    "wall_brick_door_03.png",
    "wall_brick_door_04.png",
    "wall_brick_door_05.png",
    "wall_brick_door_06.png",
    "wall_fence_01.png",
    "wall_magic_01.png",
    "wall_magic_02.png",
    "wall_metal_01.png",
    "wall_painted_01.png",
    "wall_painted_02.png",
    "wall_painted_03.png",
    "wall_painted_04.png",
    "wall_painted_05.png"
}

-- Table to store the loaded textures
local loadedTextures = {}

-- encapsulation for tile properties
function getTile(x, y)
    if not grid[y] then grid[y] = {} end
    return grid[y][x] or 0
end

function setTile(x, y, value)
    if not grid[y] then grid[y] = {} end
    grid[y][x] = value
end

-- mouse state for dragging
local isMLeft = false
local isMRight = false

function love.load()
    -- level editor window
    love.window.setTitle("Level Editor")
    love.window.setMode(1200, 500)

    -- Load wall textures dynamically (using relative paths)
    for i, filename in ipairs(wallTextures) do
        local path = "textures/walls/" .. filename
        print("Loading texture from: " .. path)  -- Debugging: print the path
        loadedTextures[i] = love.graphics.newImage(path)
    end
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

            -- convert grid coordinates to screen coordinates
            local screenX = (x * tileSize) - camX
            local screenY = (y * tileSize) - camY

            if screenX < gridAreaWidth then
                if tile > 0 then
                    -- Draw the corresponding wall texture
                    local texture = loadedTextures[tile]
                    love.graphics.setColor(1, 1, 1) -- Reset color for texture
                    love.graphics.draw(texture, screenX, screenY, 0, tileSize / texture:getWidth(), tileSize / texture:getHeight())
                else
                    -- Empty tile
                    love.graphics.setColor(0.3, 0.3, 0.3) -- Empty
                    love.graphics.rectangle("fill", screenX, screenY, tileSize, tileSize)
                end
                -- Draw grid lines
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", screenX, screenY, tileSize, tileSize)
            end
        end
    end

    -- Mouse hover preview for selected wall texture
    local mouseX, mouseY = love.mouse.getPosition()
    if mouseX < gridAreaWidth then
        local gridX = math.floor((mouseX + camX) / tileSize)
        local gridY = math.floor((mouseY + camY) / tileSize)
        local screenX = (gridX * tileSize) - camX
        local screenY = (gridY * tileSize) - camY

        -- Draw the selected texture preview where the mouse is hovering
        if selectedType > 0 then
            local previewTexture = loadedTextures[selectedType]
            love.graphics.setColor(1, 1, 1, 0.5) -- Semi-transparent for preview
            love.graphics.draw(previewTexture, screenX, screenY, 0, tileSize / previewTexture:getWidth(), tileSize / previewTexture:getHeight())
        end
    end

    -- UI panel on the right
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", gridAreaWidth, 0, 300, love.graphics.getHeight()) -- Panel size
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Options", 910, 10)

    -- Display all wall textures in the panel to select (with scrolling and highlight)
    love.graphics.print("Select Wall Texture:", 910, 50)
    for i = textureScroll + 1, math.min(textureScroll + maxTexturesOnScreen, #loadedTextures) do
        local texture = loadedTextures[i]
        local yPos = 40 + ((i - textureScroll) * 40)

        -- Highlight the selected texture with a 2px outline
        if i == selectedType then
            love.graphics.setColor(1, 1, 0) -- Yellow outline for selected texture
            love.graphics.setLineWidth(2) -- Set outline width to 2px
            love.graphics.rectangle("line", 906, yPos - 5, 38, 40)
        end

        love.graphics.setColor(1, 1, 1) -- Reset color
        love.graphics.draw(texture, 910, yPos, 0, 30 / texture:getWidth(), 30 / texture:getHeight()) -- Draw small previews
    end

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

    -- Scroll texture list with the mouse wheel or arrow keys
    if love.keyboard.isDown("up") then
        textureScroll = math.max(0, textureScroll - 1)
    end
    if love.keyboard.isDown("down") then
        textureScroll = math.min(#loadedTextures - maxTexturesOnScreen, textureScroll + 1)
    end

    -- Handle mouse drag placement for walls on the grid
    local mouseX, mouseY = love.mouse.getPosition()
    if isMLeft and mouseX < 900 then
        local gridX = math.floor((mouseX + camX) / tileSize)
        local gridY = math.floor((mouseY + camY) / tileSize)
        setTile(gridX, gridY, selectedType)
    elseif isMRight and mouseX < 900 then
        local gridX = math.floor((mouseX + camX) / tileSize)
        local gridY = math.floor((mouseY + camY) / tileSize)
        setTile(gridX, gridY, 0) -- Erase the tile
    end
end

function love.mousepressed(x, y, button)
    local gridAreaWidth = 900

    -- Start drag scroll
    if button == 1 and x > gridAreaWidth then
        isDraggingScroll = true
        dragStartY = y
    end

    -- Check if user clicked inside the texture panel area to select a wall type
    if x > gridAreaWidth and x < gridAreaWidth + 300 then
        for i = textureScroll + 1, math.min(textureScroll + maxTexturesOnScreen, #loadedTextures) do
            local yPos = 40 + ((i - textureScroll) * 40)
            if y > yPos and y < yPos + 30 then
                selectedType = i -- Select the texture clicked on
                return
            end
        end
    end

    -- Clicked inside the grid area
    if x < gridAreaWidth then
        local gridX = math.floor((x + camX) / tileSize)
        local gridY = math.floor((y + camY) / tileSize)

        if button == 1 then
            setTile(gridX, gridY, selectedType)
            isMLeft = true
        elseif button == 2 then
            setTile(gridX, gridY, 0)  -- right click to remove wall
            isMRight = true
        end
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        isMLeft = false
        isDraggingScroll = false -- End drag scroll
    elseif button == 2 then
        isMRight = false
    end
end

function love.mousemoved(x, y, dx, dy)
    -- Handle drag scrolling
    if isDraggingScroll then
        textureScroll = math.max(0, math.min(#loadedTextures - maxTexturesOnScreen, textureScroll - math.floor(dy / 10)))
    end
end

function love.wheelmoved(x, y)
    -- Scroll with the mouse wheel
    if y > 0 then
        textureScroll = math.max(0, textureScroll - 1)
    elseif y < 0 then
        textureScroll = math.min(#loadedTextures - maxTexturesOnScreen, textureScroll + 1)
    end
end
