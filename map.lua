local Map = {
    width = 16,
    height = 16,
    skybox = true,
    skybox_tex = 1,
    max_view_dist = 8,
    max_spr_dist = 20,
    fog_colour = { 0.8, 0.5, 0.7 },
    -- Wall types:
    -- 0 normal cube wall
    -- 1 sw/ne facing diagonal
    -- 2 se/nw facing diagonal
    -- 3 n/s thin walls
    -- 4 e/w thin walls
    -- 5 n/s cube
    -- 6 e/w cube
    walls = { -- {texture, wall type, collision,event flag}
        { { 3, 0, true, 0 }, { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 12, 0, true, 0 }, { 12, 0, true, 0 }, { 12, 0, true, 0 }, { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 }, },
        { { 3, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 3, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 3, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 3, 0, true, 0 },  { 18, 5, true, 0 }, { 18, 5, true, 0 }, { 18, 5, true, 0 }, { 1, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 3, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 3, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 4, 4, true, 1 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 3, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 3, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 3, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 3, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 3, 0, true, 0 }, { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 9, 3, false, 0 }, { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 0, true, 0 },  { 3, 2, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 }, },
        { { 1, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 1, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 1, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 2, true, 0 },  { 1, 0, true, 0 },  { 1, 1, true, 0 },  { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 1, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 },  { 0, 0, false, 0 }, { 1, 0, true, 0 },  { 18, 3, true, 0 }, { 1, 0, true, 0 }, },
        { { 2, 0, true, 0 }, { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 6, 3, true, 1 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 0, 0, false, 0 }, { 1, 1, true, 0 },  { 1, 0, true, 0 },  { 1, 2, true, 0 },  { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 2, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 2, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 2, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 2, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 2, 0, true, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 2, 0, true, 0 },  { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 0, 0, false, 0 }, { 1, 0, true, 0 }, },
        { { 2, 0, true, 0 }, { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 2, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 },  { 1, 0, true, 0 }, }
    },

    floors = {
        { 0, 0,  0,  0,  0,  0,  0,  0,  0,  0, 0, 0, 0,  0,  0,  0, },
        { 0, 19, 19, 19, 19, 19, 19, 0,  3,  3, 3, 0, 20, 20, 20, 0, },
        { 0, 19, 19, 19, 19, 19, 19, 0,  3,  3, 3, 0, 20, 20, 20, 0, },
        { 0, 19, 19, 19, 19, 19, 19, 0,  3,  3, 3, 2, 20, 20, 20, 0, },
        { 0, 19, 19, 19, 19, 19, 19, 0,  3,  3, 3, 0, 20, 20, 20, 0, },
        { 0, 19, 19, 19, 19, 19, 19, 0,  3,  3, 3, 0, 20, 20, 20, 0, },
        { 0, 0,  0,  1,  0,  0,  0,  3,  3,  3, 3, 0, 0,  0,  0,  0, },
        { 0, 3,  3,  3,  3,  3,  3,  3,  3,  3, 3, 3, 3,  3,  3,  0, },
        { 0, 3,  3,  3,  3,  3,  3,  3,  3,  3, 3, 3, 3,  3,  3,  0, },
        { 0, 3,  3,  3,  3,  3,  3,  3,  3,  3, 3, 3, 3,  3,  3,  0, },
        { 0, 3,  3,  3,  3,  3,  3,  3,  3,  3, 3, 3, 0,  3,  3,  0, },
        { 0, 0,  0,  13, 0,  0,  0,  0,  0,  0, 3, 3, 3,  3,  3,  0, },
        { 0, 14, 14, 14, 14, 14, 14, 14, 14, 0, 3, 3, 3,  3,  3,  0, },
        { 0, 14, 14, 14, 14, 14, 14, 14, 14, 0, 3, 3, 3,  3,  3,  0, },
        { 0, 14, 14, 14, 14, 14, 14, 14, 14, 0, 3, 3, 3,  3,  3,  0, },
        { 0, 0,  0,  0,  0,  0,  0,  0,  0,  0, 0, 0, 0,  0,  0,  0, }
    },
    ceilings = {
        { 0, 0,  0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 15, 15, 15, 0, },
        { 0, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 15, 15, 15, 0, },
        { 0, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 2, 15, 15, 15, 0, },
        { 0, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 15, 15, 15, 0, },
        { 0, 15, 15, 15, 15, 15, 15, 0, 0, 0, 0, 0, 15, 15, 15, 0, },
        { 0, 0,  0,  2,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 0,  0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 0,  0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 0,  0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 0,  0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 0,  0,  2,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 2,  2,  2,  2,  2,  2,  2, 2, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 2,  2,  2,  2,  2,  2,  2, 2, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 2,  2,  2,  2,  2,  2,  2, 2, 0, 0, 0, 0,  0,  0,  0, },
        { 0, 0,  0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0,  0,  0,  0, }
    },
    -- Load texture data
    -- Wall textures need to be loaded in using graphics to use quads
    wall_textures = {
        { img = love.graphics.newImage("/textures/walls/wall_brick_01.png"),      size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_brick_02.png"),      size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_brick_03.png"),      size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_01.png"), size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_02.png"), size = 128, is_transparent = true },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_03.png"), size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_04.png"), size = 128, is_transparent = true },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_05.png"), size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_brick_door_06.png"), size = 128, is_transparent = true },
        { img = love.graphics.newImage("/textures/walls/wall_magic_01.png"),      size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_magic_02.png"),      size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_metal_01.png"),      size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_painted_01.png"),    size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_painted_02.png"),    size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_painted_03.png"),    size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_painted_04.png"),    size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_painted_05.png"),    size = 128, is_transparent = false },
        { img = love.graphics.newImage("/textures/walls/wall_fence_01.png"),      size = 128, is_transparent = true },
    },
    -- Floor/ceiling textures need to be loaded in as image data to use getPixel
    floor_textures = { -- {texture,size}
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
    },
    -- Sprite textures need to be loaded in using graphics to use quads
    sprite_textures = {
        { img = love.graphics.newImage("/textures/sprites/sprite_barrel_01.png"), size = 128 },
        { img = love.graphics.newImage("/textures/sprites/sprite_lamp_01.png"),   size = 128 },
    },
    skybox_textures = {
        { img = love.graphics.newImage("/textures/skybox/sky_night_01.png"), width = 512, height = 128 },
    },
    -- Store functions for player interactions
    events = {
        -- Opens doors by changing the texture and disabling collision
        -----------------------------
        ---@param Map table,
        ---@param Player table,
        ---@param x number,
        ---@param y number
        function(Map, Player, x, y)
            Map.walls[y][x][1] = Map.walls[y][x][1] + 1 -- Open door texture will always be 1 ahead of the closed door
            Map.walls[y][x][3] = false
            Map.walls[y][x][4] = 0                      -- Remove the flag
        end
    },
    -- Store objects
    objs = {},
    -- Load in game objects
    -----------------------------
    ---@param Objects table
    load_objs = function(self, Objects)
        -- name, y, x, texture, x scaling factor, y scaling factor, table of extra properties
        table.insert(self.objs, Objects:create_obj("barrel", 5, 5, 1, 0.5, 0.25, {}))
        table.insert(self.objs, Objects:create_obj("barrel", 2.5, 3.1, 1, 0.5, 0.25, {}))
        table.insert(self.objs, Objects:create_obj("barrel", 2.7, 4.5, 1, 0.75, 0.5, {}))
        table.insert(self.objs, Objects:create_obj("barrel", 2.5, 5, 1, 0.5, 0.25, {}))
        table.insert(self.objs, Objects:create_obj("lamp_post", 8, 8.5, 2, 1, 2, {}))
        table.insert(self.objs, Objects:create_obj("lamp_post", 11.5, 6, 2, 1, 2, {}))
    end,
    -- Unload all objects when map is changed
    -----------------------------
    unload_objs = function(self)
        for _, obj in ipairs(self.objs) do
            obj = nil
        end
    end,
    -- Unload all textures when map is changed
    -----------------------------
    unload_textures = function(self)
        for _, w in ipairs(self.wall_textures) do
            w = nil
        end
        for _, f in ipairs(self.floor_textures) do
            f = nil
        end
        for _, sb in ipairs(self.skybox_textures) do
            sb = nil
        end
    end
}

return Map
