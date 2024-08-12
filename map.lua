local map = {
    z_buffer = {},
    width = 16,
    height = 16,
    -- Walls a texture and a wall type
    walls = {
        { { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 5, 0 }, { 5, 0 }, { 5, 0 }, { 5, 0 }, { 5, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 2, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 2, 1 }, { 2, 2 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 2, 0 }, { 0, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 0, 0 }, { 2, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 2, 1 }, { 2, 2 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 2, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 0, 0 }, { 6, 0 } },
        { { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 2, 0 }, { 5, 0 }, { 5, 0 }, { 5, 0 }, { 5, 0 }, { 5, 0 }, { 6, 0 } }
    },
    floors = {
        { 0, 0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 1, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 1, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 1, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 10, 10, 10, 10, 10, 0, 5, 5, 5, 2, 3, 4, 3, 2, 0 },
        { 0, 0,  0,  0,  0,  0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    },
    ceilings = {
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    },
    -- Sorting game objects by distance from player
    -- order is a table with the order the sprites were initialised in
    -- dist is the distance of each sprite
    -- amount is the number of sprites
    sort_objs = function(self, order, dist, amount)
        local objs = {}

        for i = 1, amount do
            local tbl = {}
            table.insert(tbl, dist[i])
            table.insert(tbl, order[i])

            table.insert(objs, tbl)
        end

        -- sort from shortest dist to highest dist
        table.sort(objs, function(tbl1, tbl2)
            return tbl1[1] < tbl2[1]
        end)

        return objs
    end,

    -- For diagonal walls
    wall_intersect = function(self, wall_x0, wall_y0, wall_x1, wall_y1, player_x, player_y, dir_x, dir_y)
        local i = { tr = -1, tw = -1 }
        local m = (wall_y1 - wall_y0) / (wall_x1 - wall_x0)

        -- Check for parallel ray
        if dir_y == m * dir_x then
            return i
        end

        i.tr = (wall_y0 + m * (player_x - wall_x0) - player_y) / (dir_y - m * dir_x)
        i.tw = (player_x + dir_x * i.tr - wall_x0) / (wall_x1 - wall_x0)
        return i
    end,

    -- Initialise the z buffer to be a table with the screens width
    init_z_buffer = function(self)
        for i = 0, SCREEN_WIDTH do
            table.insert(self.z_buffer, 0)
        end
    end,

    -- Function to draw the walls, floors, ceilings, and object sprites on the screen
    -- player is the player object
    -- sprite_objs is the table of game objects
    raycasting = function(self, player, sprite_objs)
        local max_view_dist = 8  -- Maximum distance to draw the walls
        local texture_size = 128 -- Size of textures but should be using texture.size idealy

        -- Create an image data buffer to store the pixel data
        local pixel_buffer = love.image.newImageData(800, 600)

        -- TODO try putting floor casting bakc to the start of the function
        -- hopefully might allow for angled walls
        for x = 0, SCREEN_WIDTH - 1, 1 do
            -- Get direction
            local cam_x = 2 * x / SCREEN_WIDTH - 1
            local ray_dir_x = player.dir_x + player.plane_x * cam_x
            local ray_dir_y = player.dir_y + player.plane_y * cam_x

            local map_x = math.floor(player.x)
            local map_y = math.floor(player.y)

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
                side_dist_x = (player.x - map_x) * delta_dist_x
            else
                step_x = 1
                side_dist_x = (map_x + 1.0 - player.x) * delta_dist_x
            end
            if ray_dir_y < 0 then
                step_y = -1
                side_dist_y = (player.y - map_y) * delta_dist_y
            else
                step_y = 1
                side_dist_y = (map_y + 1.0 - player.y) * delta_dist_y
            end

            -- Using DDA to find the wall
            ::rayscan::
            while view_dist < max_view_dist do
                if side_dist_x < side_dist_y then
                    side_dist_x = side_dist_x + delta_dist_x
                    map_x = map_x + step_x
                    side = 0
                    view_dist = view_dist + 1
                else
                    side_dist_y = side_dist_y + delta_dist_y
                    map_y = map_y + step_y
                    side = 1
                    view_dist = view_dist + 1
                end

                -- Check for map boundaries
                if map_x < 0 or map_x >= self.width or map_y < 0 or map_y >= self.height then
                    break
                end

                -- Check if the wall has been hit
                if self.walls[map_y][map_x][1] > 0 then
                    view_dist = max_view_dist
                end
            end

            local wall_x
            local diagonal = false
            local wall_type = self.walls[map_y][map_x][2]

            -- Check for diagonal walls
            -- if wall_type > 0 and wall_type < 5 then
            --     local i
            --     local d
            --     if wall_type == 1 then
            --         i = self:wall_intersect(map_x, map_y, map_x + 1, map_y + 1,
            --             player.x, player.y, ray_dir_x, ray_dir_y)

            --         d = player.x - map_x - player.y + map_y
            --     else
            --         i = self:wall_intersect(map_x, map_y + 1, map_x + 1, map_y,
            --             player.x, player.y, ray_dir_x, ray_dir_y)
            --         d = map_x - player.x - player.y + map_y + 1
            --     end

            --     if i.tw < 0 or i.tw >= 1 then
            --         view_dist = 0
            --         goto rayscan
            --     end

            --     perp_wall_dist = i.tr
            --     wall_x = i.tw

            --     if d < 0 then
            --         wall_x = 1 - wall_x
            --     end

            --     diagonal = true
            --     side = 3
            -- elseif wall_type == 0 then
            --     -- Calculate perpendicular wall distance
            --     if side == 0 then
            --         perp_wall_dist = (side_dist_x - delta_dist_x)
            --     else
            --         perp_wall_dist = (side_dist_y - delta_dist_y)
            --     end
            -- end

            -- Calculate perpendicular wall distance
            if side == 0 then
                perp_wall_dist = (side_dist_x - delta_dist_x)
            else
                perp_wall_dist = (side_dist_y - delta_dist_y)
            end

            -- Calculate the height of the wall slice
            local line_height = math.floor(SCREEN_HEIGHT / perp_wall_dist)
            local draw_start = -line_height / 2 + SCREEN_HEIGHT / 2
            local draw_end = line_height / 2 + SCREEN_HEIGHT / 2

            -- Calculate shading based on distance
            local shading = 1 - (perp_wall_dist / (max_view_dist / 1.5))

            -- Calculate wall texture coordinates based on side
            if not diagonal then
                if side == 0 then
                    wall_x = player.y + perp_wall_dist * ray_dir_y
                else
                    wall_x = player.x + perp_wall_dist * ray_dir_x
                end
                wall_x = wall_x - math.floor(wall_x)
            end

            local text_x = math.floor(wall_x * texture_size)
            if side == 0 and ray_dir_x > 0 then
                text_x = texture_size - text_x - 1
            end
            if side == 1 and ray_dir_y < 0 then
                text_x = texture_size - text_x - 1
            end

            -- Drawing walls --
            if self.walls[map_y][map_x][1] > 1 then
                local wall_texture = WALL_TEXTURES[self.walls[map_y][map_x][1] - 1]
                local scaling = (draw_end - draw_start) / texture_size
                local quad = love.graphics.newQuad(text_x, 0, 1, texture_size, texture_size, texture_size)

                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1, scaling)
                love.graphics.setColor(1, 1, 1)
            end

            -- Drawing floors --
            local floor_x_wall, floor_y_wall
            -- Straight walls
            if side == 0 and ray_dir_x > 0 then
                floor_x_wall = map_x
                floor_y_wall = map_y + wall_x
            elseif side == 0 and ray_dir_x < 0 then
                floor_x_wall = map_x + 1
                floor_y_wall = map_y + wall_x
            elseif side == 1 and ray_dir_y > 0 then
                floor_x_wall = map_x + wall_x
                floor_y_wall = map_y
            else
                floor_x_wall = map_x + wall_x
                floor_y_wall = map_y + 1
            end

            for y = draw_end - 1, SCREEN_HEIGHT do
                local current_dist = SCREEN_HEIGHT / (2.0 * y - SCREEN_HEIGHT)
                local weight = current_dist / perp_wall_dist

                local current_floor_x = weight * floor_x_wall + (1.0 - weight) * player.x
                local current_floor_y = weight * floor_y_wall + (1.0 - weight) * player.y

                local floor_text_x = math.floor(current_floor_x * texture_size) % texture_size
                local floor_text_y = math.floor(current_floor_y * texture_size) % texture_size

                local floor_text = self.floors[math.floor(current_floor_y)][math.floor(current_floor_x)]
                local ceiling_text = self.ceilings[math.floor(current_floor_y)][math.floor(current_floor_x)]
                local floor_shading = 1 - (current_dist / (max_view_dist / 1.5))

                if y > 0 and y < SCREEN_HEIGHT - 1 then
                    if floor_text > 0 then
                        local r, g, b = FLOOR_TEXTURES[floor_text].img:getPixel(floor_text_x, floor_text_y)
                        r, g, b = r * floor_shading, g * floor_shading, b * floor_shading
                        pixel_buffer:setPixel(x, y, r, g, b)
                    end

                    if ceiling_text > 0 then
                        local r, g, b = FLOOR_TEXTURES[ceiling_text].img:getPixel(floor_text_x, floor_text_y)
                        r, g, b = r * floor_shading, g * floor_shading, b * floor_shading
                        pixel_buffer:setPixel(x, SCREEN_HEIGHT - y, r, g, b)
                    end
                end
            end

            -- Store distance of every wall hit in the Z buffer
            self.z_buffer[x] = perp_wall_dist
        end

        -- Drawing final image. This is just for floors and ceilings
        local final_frame = love.graphics.newImage(pixel_buffer)
        love.graphics.draw(final_frame)

        -- Sprite casting --
        for spr = 1, #sprite_objs do
            local dist = ((player.x - sprite_objs[spr].x) ^ 2) + ((player.y - sprite_objs[spr].y) ^ 2)
            -- Only draw sprite if the distance is with the max view distance
            if dist < max_view_dist then
                -- Get position
                local sprite_x = sprite_objs[spr].x - player.x
                local sprite_y = sprite_objs[spr].y - player.y

                -- Transform sprite with the inverse camera matrix
                -- [ plane_x   dir_x ] -1                                       [ dir_y      -dir_x ]
                -- [                 ]   =  1/(plane_x*dir_y-dir_x*plane_y) *   [                   ]
                -- [ plane_y   dir_y ]                                          [ -plane_y  plane_x ]

                local inv_det = 1 / (player.plane_x * player.dir_y - player.dir_x * player.plane_y)

                local transofrm_x = inv_det * (player.dir_y * sprite_x - player.dir_x * sprite_y)
                local transform_y = inv_det * (-player.plane_y * sprite_x + player.plane_x * sprite_y)

                local sprite_screen_x = math.floor((SCREEN_WIDTH / 2) * (1 + transofrm_x / transform_y))

                -- Line height
                local sprite_height = math.abs(math.floor(SCREEN_HEIGHT / (transform_y)))
                local draw_start_y = -sprite_height / 2 + SCREEN_HEIGHT / 2
                if draw_start_y < 0 then draw_start_y = 0 end
                local draw_end_y = sprite_height / 2 + SCREEN_HEIGHT / 2
                if draw_end_y >= SCREEN_HEIGHT then draw_end_y = SCREEN_HEIGHT - 1 end

                -- Texture width
                local sprite_width = math.abs(math.floor(SCREEN_HEIGHT / (transform_y)))
                local draw_start_x = -sprite_width / 2 + sprite_screen_x
                if draw_start_x < 0 then draw_start_x = 0 end
                local draw_end_x = sprite_width / 2 + sprite_screen_x
                if draw_end_x >= SCREEN_WIDTH then draw_end_x = SCREEN_WIDTH - 1 end

                local text_num = sprite_objs[spr].texture
                for stripe = draw_start_x, draw_end_x do
                    -- Check if the sprite  should be visible before drawing
                    if stripe > 0 and stripe < SCREEN_WIDTH
                        and transform_y < self.z_buffer[stripe]
                        and transform_y > 0 then
                        -- NOTE 256 might just be texture size * 4
                        local text_x = math.floor(256 * (stripe - (-sprite_width / 2 + sprite_screen_x))
                            * texture_size / sprite_width) / 256

                        local sprite_texture = SPRITE_TEXTURES[text_num]
                        local scaling = (draw_end_y - draw_start_y) / texture_size
                        local quad = love.graphics.newQuad(text_x, 0, 1, texture_size, texture_size, texture_size)

                        love.graphics.setColor(0, 0, 0)
                        love.graphics.draw(sprite_texture.img, quad, stripe, draw_start_x, 0, 1, scaling)
                        love.graphics.setColor(1, 1, 1)
                    end
                end
            end
        end
    end
}

return map
