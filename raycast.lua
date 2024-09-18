-- TODO:
-- Variable height walls would be really nice

-- Module for raycasting and rendering the map plus objects/sprites to the screen
local Raycaster = {
    -- Calculate itersection of diagonal walls to get the perpendicular distance from player
    -----------------------------
    ---@param wall_x0 number,
    ---@param wall_y0 number,
    ---@param wall_x1 number,
    ---@param wall_y1 number,
    ---@param player_x number,
    ---@param player_y number,
    ---@param dir_x number,
    ---@param dir_y number,
    ---@return number i
    wall_intersect = function(self, wall_x0, wall_y0, wall_x1, wall_y1, player_x, player_y, dir_x, dir_y)
        local i = { tr = -1, tw = -1 }                      -- Intersection results: tr = ray distance, tw = wall intersection point
        local m = (wall_y1 - wall_y0) / (wall_x1 - wall_x0) -- Slope

        -- Check for parallel wall
        if dir_y == m * dir_x then
            return i
        end

        -- Intersection distance
        i.tr = (wall_y0 + m * (player_x - wall_x0) - player_y) / (dir_y - m * dir_x)
        i.tw = (player_x + dir_x * i.tr - wall_x0) / (wall_x1 - wall_x0)
        return i
    end,

    -- Draw the skybox image and wrap it around the Player
    -----------------------------
    ---@param Player table,
    ---@param Map table,
    draw_skybox = function(self, Player, Map)
        local skybox_tex = Map.skybox_textures[Map.skybox_tex]
        local scale = 2
        local scaled_width = skybox_tex.width * scale

        -- Get Player angle
        local radians = math.atan2(Player.dir_y, Player.dir_x)
        local degrees = math.deg(radians)
        -- Adjust to 0-360 degree range
        if degrees < 0 then
            degrees = degrees + 360
        end

        -- Make image wrap around the screen
        local skybox_x = -((degrees / 360) * scaled_width)

        for i = 0, 2 do
            love.graphics.draw(skybox_tex.img, skybox_x + (scaled_width * i), 0,
                0, scale, scale)
        end
    end,

    -- Draw floors and ceilings based on their respective tables in the Map by placing pixels on an image data buffer
    -----------------------------
    ---@param Player table,
    ---@param Map table,
    ---@param pixel_buffer imageData,
    ---@param texture_size number,
    ---@param screen_width number,
    ---@param screen_height number,
    ---@return imageData pixel_buffer
    draw_floors = function(self, Player, Map, pixel_buffer, texture_size, screen_width, screen_height)
        local half_screen_height = screen_height / 2
        local pos_z = 0.5 * screen_height -- Reference distance for perspective projection

        for y = half_screen_height, screen_height - 1 do
            local p = y - half_screen_height             -- Vertical position relative to the center
            local row_dist = pos_z / (p ~= 0 and p or 1) -- Avoid division by zero

            local inv_screen_width = 1 / screen_width
            local player_dir_plane_x = Player.dir_x + Player.plane_x
            local player_dir_plane_y = Player.dir_y + Player.plane_y

            local floor_step_x = row_dist * (player_dir_plane_x - (Player.dir_x - Player.plane_x)) * inv_screen_width
            local floor_step_y = row_dist * (player_dir_plane_y - (Player.dir_y - Player.plane_y)) * inv_screen_width
            local floor_x = Player.x + row_dist * (Player.dir_x - Player.plane_x)
            local floor_y = Player.y + row_dist * (Player.dir_y - Player.plane_y)

            if row_dist < Map.max_view_dist then
                for x = 0, screen_width - 1 do
                    -- Get position
                    local cell_x = math.abs(math.floor(floor_x))
                    local cell_y = math.abs(math.floor(floor_y))

                    if cell_x > 0 and cell_x < Map.width
                        and cell_y > 0 and cell_y < Map.height then
                        local floor_tex = Map.floors[cell_y][cell_x]
                        local ceiling_tex = Map.ceilings[cell_y][cell_x]

                        -- Texture coordinates and clamp them
                        local tx = math.floor(texture_size * (floor_x - cell_x)) % texture_size
                        local ty = math.floor(texture_size * (floor_y - cell_y)) % texture_size
                        tx = math.max(0, math.min(tx, texture_size - 1))
                        ty = math.max(0, math.min(ty, texture_size - 1))

                        -- Calculate shading based on distance
                        local shading = 1 - (row_dist / (Map.max_view_dist / 1.5))

                        if y > 0 and y < screen_height then
                            -- Floor
                            if floor_tex > 0 then
                                local r, g, b, a = Map.floor_textures[floor_tex].img:getPixel(tx, ty)
                                r, g, b = r * shading, g * shading, b * shading

                                if a == 1 then
                                    pixel_buffer:setPixel(x, y, r, g, b)
                                end
                            end

                            -- Ceiling
                            if ceiling_tex > 0 then
                                local r, g, b, a = Map.floor_textures[ceiling_tex].img:getPixel(tx, ty)
                                r, g, b = r * shading, g * shading, b * shading
                                if a == 1 then
                                    pixel_buffer:setPixel(x, screen_height - y - 1, r, g, b)
                                end
                            end
                        end
                    end
                    -- Incremrement to next tile
                    floor_x = floor_x + floor_step_x
                    floor_y = floor_y + floor_step_y
                end
            end
        end

        return pixel_buffer
    end,

    -- Draw walls based on the wall table in the Map and sets their distance in the z buffer
    -----------------------------
    ---@param z_buffer table,
    ---@param transparent_walls table,
    ---@param Player table,
    ---@param Map table,
    ---@param texture_size number,
    ---@param screen_width number,
    ---@param screen_height number,
    ---@return table z_buffer
    ---@return table transparent_walls
    draw_walls = function(self, z_buffer, transparent_walls, Player, Map, texture_size, screen_width, screen_height)
        local half_screen_height = screen_height / 2
        for x = 1, #z_buffer do
            -- Get direction
            local cam_x = 2 * x / screen_width - 1
            local ray_dir_x = Player.dir_x + Player.plane_x * cam_x
            local ray_dir_y = Player.dir_y + Player.plane_y * cam_x

            local Map_x = math.floor(Player.x)
            local Map_y = math.floor(Player.y)

            local side_dist_x, side_dist_y
            local delta_dist_x = (ray_dir_x == 0) and 1e30 or math.abs(1 / ray_dir_x)
            local delta_dist_y = (ray_dir_y == 0) and 1e30 or math.abs(1 / ray_dir_y)
            local perp_wall_dist

            local step_x, step_y
            local side
            local view_dist = 0

            -- Initial step and side distance based on ray direction
            if ray_dir_x < 0 then
                step_x = -1
                side_dist_x = (Player.x - Map_x) * delta_dist_x
            else
                step_x = 1
                side_dist_x = (Map_x + 1.0 - Player.x) * delta_dist_x
            end
            if ray_dir_y < 0 then
                step_y = -1
                side_dist_y = (Player.y - Map_y) * delta_dist_y
            else
                step_y = 1
                side_dist_y = (Map_y + 1.0 - Player.y) * delta_dist_y
            end

            -- Using DDA to find the wall
            ::rayscan::
            while view_dist < Map.max_view_dist do
                if side_dist_x < side_dist_y then
                    side_dist_x = side_dist_x + delta_dist_x
                    Map_x = Map_x + step_x
                    side = 0
                    view_dist = view_dist + 1
                else
                    side_dist_y = side_dist_y + delta_dist_y
                    Map_y = Map_y + step_y
                    side = 1
                    view_dist = view_dist + 1
                end

                -- Check for Map boundaries
                if Map_x < 0 or Map_x >= Map.width or Map_y < 0 or Map_y >= Map.height then
                    break
                end

                -- Check if the wall has been hit
                if Map.walls[Map_y][Map_x][1] > 0 then
                    view_dist = Map.max_view_dist
                end
            end

            if Map.walls[Map_y][Map_x][1] == 0 then
                -- restart raycasting
                view_dist = 0
                goto rayscan
            end

            local wall_x
            local diagonal = false
            local wall_type = Map.walls[Map_y][Map_x][2]
            local wall_texture = Map.wall_textures[Map.walls[Map_y][Map_x][1]]

            -- Check wall types
            if wall_type == 1 or wall_type == 2 then -- Diagonal
                local i
                local d
                if wall_type == 1 then
                    i = self:wall_intersect(Map_x, Map_y, Map_x + 1, Map_y + 1,
                        Player.x, Player.y, ray_dir_x, ray_dir_y)

                    d = Player.x - Map_x - Player.y + Map_y
                else
                    i = self:wall_intersect(Map_x, Map_y + 1, Map_x + 1, Map_y,
                        Player.x, Player.y, ray_dir_x, ray_dir_y)
                    d = Map_x - Player.x - Player.y + Map_y + 1
                end

                if i.tw < 0 or i.tw >= 1 then
                    view_dist = 0
                    goto rayscan
                end

                perp_wall_dist = i.tr
                wall_x = i.tw

                if d < 0 then
                    wall_x = 1 - wall_x
                end

                diagonal = true
                side = 2
            elseif wall_type == 3 or wall_type == 4 then -- Thin walls
                if side == 1 then
                    local dist = side_dist_y - 0.5
                    if side_dist_x < dist then
                        view_dist = 0
                        goto rayscan
                    end
                    perp_wall_dist = dist
                else
                    local dist = side_dist_x - 0.5
                    if side_dist_y < dist then
                        view_dist = 0
                        goto rayscan
                    end
                    perp_wall_dist = dist
                end
            elseif wall_type == 5 then -- n/s only
                if side == 1 then
                    local dist = (side_dist_y - delta_dist_y)
                    perp_wall_dist = dist
                else
                    view_dist = 0
                    goto rayscan
                end
            elseif wall_type == 6 then -- e/w only
                if side == 1 then
                    view_dist = 0
                    goto rayscan
                else
                    local dist = (side_dist_x - delta_dist_x)
                    perp_wall_dist = dist
                end
            elseif wall_type == 0 then -- Regular block walls
                if side == 0 then
                    perp_wall_dist = (side_dist_x - delta_dist_x)
                else
                    perp_wall_dist = (side_dist_y - delta_dist_y)
                end
            end

            -- Calculate wall texture coordinates based on side
            if not diagonal then
                if side == 0 then
                    wall_x = Player.y + perp_wall_dist * ray_dir_y
                else
                    wall_x = Player.x + perp_wall_dist * ray_dir_x
                end
                wall_x = wall_x - math.floor(wall_x)
            end

            -- Drawing walls --
            -- Calculate the height of the wall slice
            local line_height = math.floor(screen_height / perp_wall_dist) + 1
            local draw_start = (-line_height / 2 + half_screen_height)
            local draw_end = line_height / 2 + half_screen_height

            -- Calculate shading based on distance
            local shading = 1 - (perp_wall_dist / (Map.max_view_dist / 1.5))

            -- Calculate wall texture coordinates based on side
            local tex_x = math.floor(wall_x * texture_size)
            if side == 0 and ray_dir_x > 0 then
                tex_x = texture_size - tex_x - 1
            end
            if side == 1 and ray_dir_y < 0 then
                tex_x = texture_size - tex_x - 1
            end

            local scaling = (draw_end + 1 - draw_start) / texture_size
            local quad = love.graphics.newQuad(tex_x, 0, 1, texture_size, texture_size, texture_size)

            z_buffer[x] = perp_wall_dist

            -- Check if the wall is a transparent wall
            if wall_texture.is_transparent then
                --Store in transparent walls tbale to be drawn later
                table.insert(transparent_walls, {
                    dist = perp_wall_dist,
                    shading = shading,
                    wall_texture = wall_texture,
                    quad = quad,
                    x = x,
                    draw_start = draw_start,
                    scaling = scaling
                })
                -- restart raycasting
                view_dist = 0
                goto rayscan
            else -- Just draw if not
                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1, scaling)
                love.graphics.setColor(1, 1, 1)
            end
        end
        return z_buffer, transparent_walls
    end,

    -- Draw the sprites found in the sprite objects table
    -----------------------------
    ---@param z_buffer table,
    ---@param Player table,
    ---@param Map table,
    ---@param SpriteObjs table,
    ---@param texture_size number,
    ---@param screen_width number,
    ---@param screen_height number,
    ---@return table z_buffer
    draw_sprites = function(self, z_buffer, Player, Map, SpriteObjs, texture_size, screen_width, screen_height)
        local half_screen_width = screen_width / 2
        local half_screen_height = screen_height / 2

        -- Get distance from Player for each object and sort in reverse order before they are drawn
        for i = 1, #SpriteObjs do
            SpriteObjs[i].distance = ((Player.x - SpriteObjs[i].x) ^ 2) + ((Player.y - SpriteObjs[i].y) ^ 2)
        end
        table.sort(SpriteObjs, function(a, b) return a.distance > b.distance end)

        for spr = 1, #SpriteObjs do
            -- Only draw sprite if the distance is with the max view distance
            if SpriteObjs[spr].distance < Map.max_spr_dist then
                -- Get x position relative to the Player
                local sprite_x = SpriteObjs[spr].x - Player.x
                local sprite_y = SpriteObjs[spr].y - Player.y

                -- Transform sprite with the inverse camera matrix
                local inv_det = 1 / (Player.plane_x * Player.dir_y - Player.dir_x * Player.plane_y)
                local transform_x = inv_det * (Player.dir_y * sprite_x - Player.dir_x * sprite_y)
                local transform_y = inv_det * (-Player.plane_y * sprite_x + Player.plane_x * sprite_y)

                -- Screen position
                local sprite_screen_x = math.floor((half_screen_width) * (1 + transform_x / transform_y))

                -- Line height
                local sprite_height = math.abs(math.floor(screen_height / (transform_y)))
                local draw_start_y = (half_screen_height - (sprite_height * SpriteObjs[spr].y_scaling) / 2)
                local draw_end_y = sprite_height / 2 + half_screen_height

                -- Texture width
                local sprite_width = math.abs(math.floor(screen_width / (transform_y))) * SpriteObjs[spr].x_scaling
                local draw_start_x = math.floor(sprite_screen_x - sprite_width / 2)
                local draw_end_x = math.floor(sprite_width / 2 + sprite_screen_x)

                -- Calculate shading based on distance
                local shading = 1 - (transform_y / (Map.max_view_dist / 1.5))
                local tex_num = 1
                if SpriteObjs[spr].is_directional then
                    -- If the sprite is directional then you need to use the player direction to get the texture
                    tex_num = SpriteObjs[spr].textures[Player.dir]
                else
                    tex_num = SpriteObjs[spr].textures[1]
                end

                for stripe = draw_start_x, draw_end_x do
                    -- Check if the sprite should be visible before drawing
                    if stripe > 0 and stripe < #z_buffer and z_buffer[stripe]
                        and transform_y < (z_buffer[stripe] or math.huge) and transform_y > 0 then
                        z_buffer[stripe] = transform_y

                        -- NOTE 256 might just be texture_size * 4
                        local tex_x = math.floor(256 * (stripe - (-sprite_width / 2 + sprite_screen_x))
                            * texture_size / sprite_width) / 256

                        local sprite_texture = Map.sprite_textures[tex_num]
                        local scaling = (draw_end_y - draw_start_y) / texture_size
                        local quad = love.graphics.newQuad(tex_x, 0, 1, texture_size, texture_size, texture_size)

                        love.graphics.setColor(shading, shading, shading)
                        love.graphics.draw(sprite_texture.img, quad, stripe, draw_start_y, 0, 1, scaling)
                        love.graphics.setColor(1, 1, 1)
                    end
                end
            end
        end
        return z_buffer
    end,

    -- Render walls, floors, ceilings, skybox, and objects/sprites to the screen
    -----------------------------
    ---@param Player table,
    ---@param Map table,
    ---@param screen_width number,
    ---@param screen_height number
    raycasting = function(self, Player, Map, screen_width, screen_height)
        local texture_size = 128 -- Size of textures but should be using texture.size idealy

        -- Create image data to store the pixel data so floors and ceiling can all be drawn with one draw function
        local pixel_buffer = love.image.newImageData(screen_width, screen_height)
        local z_buffer = {}
        for i = 1, screen_width do
            table.insert(z_buffer, 999)
        end

        if Map.skybox then
            self:draw_skybox(Player, Map)
        end

        pixel_buffer = self:draw_floors(Player, Map, pixel_buffer, texture_size, screen_width, screen_height)
        local final_frame = love.graphics.newImage(pixel_buffer)
        love.graphics.draw(final_frame)

        local transparent_walls = {}
        z_buffer, transparent_walls = self:draw_walls(z_buffer, transparent_walls, Player, Map, texture_size,
            screen_width, screen_height)

        z_buffer = self:draw_sprites(z_buffer, Player, Map, Map.objs, texture_size, screen_width, screen_height)

        -- Sort transaprent walls by distance and then draw them after everything
        table.sort(transparent_walls, function(a, b) return a.dist > b.dist end)
        for _, t_wall in ipairs(transparent_walls) do
            if t_wall.dist < z_buffer[t_wall.x] then
                love.graphics.setColor(t_wall.shading, t_wall.shading, t_wall.shading)
                love.graphics.draw(t_wall.wall_texture.img, t_wall.quad, t_wall.x, t_wall.draw_start, 0, 1,
                    t_wall.scaling)
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
}

return Raycaster
