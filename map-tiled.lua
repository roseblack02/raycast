local Map={
    width = 0, height = 0,
    tile_width = 0, tile_height = 0,
    max_view_dist = 8, max_spr_dist = 20,
    fog_colour = { 0.9025, 0.9025, 1 },
    -- Tile values are split across difference layers as that is how they are exported in Tiled
    layers={
        floors={},
        walls={},
        ceilings={},
        types={},
        flags={},
        collisions={},
    },
    -- Wall textures need to be loaded in using graphics to use quads
    wall_textures={
        --{ img = love.graphics.newImage("path"), size = int, is_transparant=bool },
    },
    -- Floor/ceiling textures need to be loaded in as image data to use getPixel
    floor_textures = {
        --{ img = love.image.newImageData("path"), size = int },
    },
    -- Sprite textures need to be loaded in using graphics to use quads
    sprite_textures = {
        --{ img = love.graphics.newImage("path"), size = int },
    },
    skybox = true,
    skybox_texture = {
        --{ img = love.graphics.newImage("path"), width = int, height = int },
    },
    -- List of functions for player interactions
    events = {
        -- Opens doors by changing the texture and disabling collision
        -----------------------------
        ---@param Map table,
        ---@param Player table,
        ---@param x number,
        ---@param y number
        function(Map, Player, x, y)
            Map.layers.walls[y][x] = Map.layers.walls[y][x] + 1 -- Open door texture will always be 1 ahead of the closed door
            Map.layers.collisions[y][x] = false
            Map.layers.flags[y][x] = 0                          -- Remove the flag
        end,
    },
    -- Load maps from Tiled .lua exports
    -----------------------------
    ---@param dir string,
    ---@param file_name string
    init_map=function(self,dir,file_name) --load map from file path (export tiled map DON"T EMBED TILESET)
        local path=dir.. file_name
        path = path:gsub("/", ".") 
        local map_file=require(path)
        self.width=map_file.width
        self.height=map_file.height
        self.tile_width=map_file.tilewidth 
        self.tile_height=map_file.tileheight
        self.max_view_dist=map_file.properties["view-dist"]
        self.max_spr_dist=map_file.properties["spr-dist"]

        -- Tiled stores this is hexidecimal so needs to be converted to {r,g,b}
        local hex_fog = map_file.properties["fog"]
        hex_fog = string.sub(hex_fog,4)
        self.fog_colour= {
            tonumber(string.sub(hex_fog, 1, 2), 16)/255,
            tonumber(string.sub(hex_fog, 3, 4), 16)/255,
            tonumber(string.sub(hex_fog, 5, 6), 16)/255
        }  
        print(hex_fog)
        print(self.fog_colour[1])
        print(self.fog_colour[2])
        print(self.fog_colour[3])

        -- Load in textures
        self:load_textures(map_file.properties)

        -- -1 to exclude objects for now
        -- Extracting the data from the Tiled map layers and putting in correct format
        for i=1, #map_file.layers-1 do
            local layer_name = map_file.layers[i].name
            local tiled_data = map_file.layers[i].data

            -- Tiled GIDs are offset by their tileset's firstgid
            local offset = 0
            if layer_name == 'wall' then
                offset = 64
            elseif layer_name == 'collision' then
                offset = 128
            elseif layer_name == 'flag' then
                offset = 192
            elseif layer_name == 'type' then
                offset = 256
            end

            local data = {}
            local k = 1 -- Index for the 1D Tiled data array
            for y = 1, self.height do
                local row = {}
                for x = 1, self.width do
                    -- Get the value from the 1D array and apply the offset
                    local val = tiled_data[k]
                    if val > 0 then
                        val = val - offset
                    else
                        val = 0 -- Ensure 0 remains 0
                    end
                    table.insert(row, val)
                    k = k + 1 -- Move to the next item in the 1D array
                end
                table.insert(data, row)
            end

            if layer_name == 'floor' then
                self.layers.floors = data
            elseif layer_name == 'wall' then
                self.layers.walls = data
            elseif layer_name == 'ceiling' then
                self.layers.ceilings = data
            elseif layer_name == 'type' then
                self.layers.types = data
            elseif layer_name == 'flag' then
                self.layers.flags = data
            elseif layer_name == 'collision' then
                -- Collsion uses booleans
                local collision_data = {}
                for y = 1, self.height do
                    local row = {}
                    for x = 1, self.width do
                        -- Tiled uses 0 for no collision, and a tile GID (>0) for collision
                        table.insert(row, data[y][x] > 0) 
                    end
                    table.insert(collision_data, row)
                end
                self.layers.collisions = collision_data
            end
        end

        self.map_objs=map_file.layers[#map_file.layers].objects
    end,
    -- Load in textures from the maps properties
    -----------------------------
    ---@param props table
    load_textures = function(self, props)
        -- Map uses tileset sheets but we use individual textures with differetn types for floor and walls
        -- Custom properties are set in Tiled to point in corect directory
        local walls=love.filesystem.getDirectoryItems(props["wall-tex-dir"])
        local floors=love.filesystem.getDirectoryItems(props["floor-tex-dir"])
        local sprites=love.filesystem.getDirectoryItems(props["sprites-tex-dir"])

        -- Loop through directory and load image files in correct order
        for i=2, #walls do
            local transparent = string.find(walls[i], 'transparent', 1, true) ~= nil
            local tex={
                img=love.graphics.newImage(props["wall-tex-dir"].. walls[i]),
                is_transparent=transparent,
                size=self.tile_width,
            }
            table.insert(self.wall_textures,tex)
        end

        for i=2, #floors do
            local transparent = string.find(walls[i], 'transparent', 1, true) ~= nil
            local tex={
                img=love.image.newImageData(props["floor-tex-dir"].. floors[i]),
                is_transparent=transparent,
                size=self.tile_width,
            }
            table.insert(self.floor_textures,tex)
        end

        -- Sprite textures
        for i=1, #sprites do
            local tex={
                img=love.graphics.newImage(props["sprites-tex-dir"].. sprites[i]),
                size=self.tile_width,
            }
            table.insert(self.sprite_textures,tex)
        end

        -- Skybox data
        self.skybox = props["skybox"]
        self.skybox_texture = {
            img = love.graphics.newImage(props["skybox-tex"]), 
            width = props["skybox-width"], 
            height = props["skybox-height"]
        }
    end,

    -- Store objects
    objs = {},
    map_objs={},
    -- Load in game objects
    -----------------------------
    ---@param Objects table
    load_objs = function(self, Objects)
        -- Tiled sets coords as pixels and not in grid cells so need to divide by tile size
        for _, obj in ipairs(self.map_objs) do
            -- name, y, x, textures table, x scaling factor, y scaling factor,is_directional, table of extra properties
            table.insert(self.objs,Objects:create_obj(
                obj.name,
                obj.y/(self.tile_height-1),
                obj.x/(self.tile_width-1),
                {obj.properties["texture-id"]}, -- table in case the sprite is directional
                obj.properties["x-scale"],
                obj.properties["y-scale"],
                obj.properties["is-directional"],
                {} -- optional properties
            ))
        end
    end,
    -- Unload all objects when map is changed
    -----------------------------
    unload_objs = function(self)
        for _, obj in ipairs(self.objs) do
            obj = nil
        end
    end,
}

return Map