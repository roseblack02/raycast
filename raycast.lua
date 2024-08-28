local raycaster = {
    z_buffer = {},
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
    -- sprite_objs is the table of game objects
    raycasting = function(self, player, sprite_objs, map)
        local texture_size = 128 -- Size of textures but should be using texture.size idealy

        -- Drawing skybox --
        if map.skybox then
            local skybox_tex = SKYBOX_TEXTURES[1]
            local scale = 2
            local scaled_width = skybox_tex.width * scale

            -- Get player angle
            local radians = math.atan2(player.dir_y, player.dir_x)
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
        end

        -- Drawing the floor and ceiling --
        -- Create an image data to store the pixel data
        local pixel_buffer = love.image.newImageData(800, 600)

        local starting_point = SCREEN_HEIGHT / 2
        for y = starting_point, SCREEN_HEIGHT - 1 do
            local p = y - SCREEN_HEIGHT / 2
            local pos_z = 0.5 * SCREEN_HEIGHT
            local row_dist = pos_z / (p ~= 0 and p or 1) -- Avoid division by zero

            local floor_step_x = row_dist * (player.dir_x + player.plane_x -
                (player.dir_x - player.plane_x)) / SCREEN_WIDTH
            local floor_step_y = row_dist * (player.dir_y + player.plane_y -
                (player.dir_y - player.plane_y)) / SCREEN_WIDTH
            local floor_x = player.x + row_dist * (player.dir_x - player.plane_x)
            local floor_y = player.y + row_dist * (player.dir_y - player.plane_y)

            if row_dist < map.max_view_dist then
                for x = 0, SCREEN_WIDTH - 1 do
                    local cell_x = math.floor(floor_x)
                    local cell_y = math.floor(floor_y)

                    local tx = math.floor(texture_size * (floor_x - cell_x)) % texture_size
                    local ty = math.floor(texture_size * (floor_y - cell_y)) % texture_size

                    -- Ensure tx and ty are within valid range
                    tx = math.max(0, math.min(tx, texture_size - 1))
                    ty = math.max(0, math.min(ty, texture_size - 1))

                    -- Get texture from respective tables
                    local cell_x = math.abs(math.floor(floor_x))
                    local cell_y = math.abs(math.floor(floor_y))

                    if cell_x > 0 and cell_x < map.width
                        and cell_y > 0 and cell_y < map.height then
                        local floor_tex = map.floors[cell_y][cell_x]
                        local ceiling_tex = map.ceilings[cell_y][cell_x]

                        local shading = 1 - (row_dist / (map.max_view_dist / 1.5))

                        if y > 0 and y < SCREEN_HEIGHT then
                            if floor_tex > 0 then
                                local r, g, b = FLOOR_TEXTURES[floor_tex].img:getPixel(tx, ty)
                                r, g, b = r * shading, g * shading, b * shading
                                pixel_buffer:setPixel(x, y, r, g, b)
                            end

                            if ceiling_tex > 0 then
                                local r, g, b = FLOOR_TEXTURES[ceiling_tex].img:getPixel(tx, ty)
                                r, g, b = r * shading, g * shading, b * shading
                                pixel_buffer:setPixel(x, SCREEN_HEIGHT - y - 1, r, g, b)
                            end
                        end
                    end
                    floor_x = floor_x + floor_step_x
                    floor_y = floor_y + floor_step_y
                end
            end
        end

        -- Drawing final image. This is just for floors and ceilings
        local final_frame = love.graphics.newImage(pixel_buffer)
        love.graphics.draw(final_frame)

        -- Drawing walls --
        for x = 0, SCREEN_WIDTH - 1 do
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
            while view_dist < map.max_view_dist do
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
                if map_x < 0 or map_x >= map.width or map_y < 0 or map_y >= map.height then
                    break
                end

                -- Check if the wall has been hit
                if map.walls[map_y][map_x][1] > 0 then
                    view_dist = map.max_view_dist
                end
            end

            local wall_x
            local diagonal = false
            local wall_type = map.walls[map_y][map_x][2]

            -- Check wall types
            if wall_type == 1 or wall_type == 2 then -- Diagonal
                local i
                local d
                if wall_type == 1 then
                    i = self:wall_intersect(map_x, map_y, map_x + 1, map_y + 1,
                        player.x, player.y, ray_dir_x, ray_dir_y)

                    d = player.x - map_x - player.y + map_y
                else
                    i = self:wall_intersect(map_x, map_y + 1, map_x + 1, map_y,
                        player.x, player.y, ray_dir_x, ray_dir_y)
                    d = map_x - player.x - player.y + map_y + 1
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
                side = 3
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
            elseif wall_type == 0 then -- Regular block walls
                if side == 0 then
                    perp_wall_dist = (side_dist_x - delta_dist_x)
                else
                    perp_wall_dist = (side_dist_y - delta_dist_y)
                end
            end

            -- Calculate the height of the wall slice
            local line_height = math.floor(SCREEN_HEIGHT / perp_wall_dist) + 1
            local draw_start = (-line_height / 2 + SCREEN_HEIGHT / 2)
            local draw_end = line_height / 2 + SCREEN_HEIGHT / 2

            -- Calculate shading based on distance
            local shading = 1 - (perp_wall_dist / (map.max_view_dist / 1.5))

            -- Calculate wall texture coordinates based on side
            if not diagonal then
                if side == 0 then
                    wall_x = player.y + perp_wall_dist * ray_dir_y
                else
                    wall_x = player.x + perp_wall_dist * ray_dir_x
                end
                wall_x = wall_x - math.floor(wall_x)
            end

            local tex_x = math.floor(wall_x * texture_size)
            if side == 0 and ray_dir_x > 0 then
                tex_x = texture_size - tex_x - 1
            end
            if side == 1 and ray_dir_y < 0 then
                tex_x = texture_size - tex_x - 1
            end

            -- Drawing walls --
            if map.walls[map_y][map_x][1] > 0 then
                local wall_texture = WALL_TEXTURES[map.walls[map_y][map_x][1]]
                local scaling = (draw_end + 1 - draw_start) / texture_size
                local quad = love.graphics.newQuad(tex_x, 0, 1, texture_size, texture_size, texture_size)

                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1, scaling)
                love.graphics.setColor(1, 1, 1)

                -- Draw upper layer walls
                -- love.graphics.setColor(shading, shading, shading)
                -- love.graphics.draw(wall_texture.img, quad, x, draw_start - line_height, 0, 1, scaling)
                -- love.graphics.setColor(1, 1, 1)
            end

            -- Store distance of every wall hit in the Z buffer
            self.z_buffer[x] = perp_wall_dist
        end

        -- Get distance from player for each object
        for i = 1, #sprite_objs do
            sprite_objs[i].distance = ((player.x - sprite_objs[i].x) ^ 2) + ((player.y - sprite_objs[i].y) ^ 2)
        end

        -- Need to sort sprites by distance in reverse so they are drawn in the correct order
        local function sort_spr(a, b)
            return a.distance > b.distance
        end
        table.sort(sprite_objs, sort_spr)

        -- Sprite casting --
        for spr = 1, #sprite_objs do
            -- Only draw sprite if the distance is with the max view distance
            if sprite_objs[spr].distance < map.max_spr_dist then
                -- Get x position relative to the player
                local sprite_x = sprite_objs[spr].x - player.x
                local sprite_y = sprite_objs[spr].y - player.y

                -- Transform sprite with the inverse camera matrix
                -- [ plane_x   dir_x ] -1                                       [ dir_y      -dir_x ]
                -- [                 ]   =  1/(plane_x*dir_y-dir_x*plane_y) *   [                   ]
                -- [ plane_y   dir_y ]                                          [ -plane_y  plane_x ]

                local inv_det = 1 / (player.plane_x * player.dir_y - player.dir_x * player.plane_y)
                local transform_x = inv_det * (player.dir_y * sprite_x - player.dir_x * sprite_y)
                local transform_y = inv_det * (-player.plane_y * sprite_x + player.plane_x * sprite_y)


                local sprite_screen_x = math.floor((SCREEN_WIDTH / 2) * (1 + transform_x / transform_y))

                -- Line height
                local sprite_height = math.abs(math.floor(SCREEN_HEIGHT / (transform_y)))
                local draw_start_y = -sprite_height / 2 + SCREEN_HEIGHT / 2
                local draw_end_y = sprite_height / 2 + SCREEN_HEIGHT / 2

                -- Texture width
                local sprite_width = math.abs(math.floor(SCREEN_WIDTH / (transform_y)))
                if sprite_width > sprite_height then sprite_width = sprite_height end
                local draw_start_x = -sprite_width / 2 + sprite_screen_x
                local draw_end_x = sprite_width / 2 + sprite_screen_x

                -- Calculate shading based on distance
                local shading = 2.5 - (sprite_objs[spr].distance / (map.max_view_dist))
                local tex_num = sprite_objs[spr].texture

                for stripe = draw_start_x, draw_end_x do
                    -- Check if the sprite  should be visible before drawing
                    if stripe > 0 and stripe < SCREEN_WIDTH
                        and transform_y < (self.z_buffer[stripe] or math.huge) and transform_y > 0 then
                        -- NOTE 256 might just be texture_size * 4
                        local tex_x = math.floor(256 * (stripe - (-sprite_width / 2 + sprite_screen_x))
                            * texture_size / sprite_width) / 256

                        local sprite_texture = SPRITE_TEXTURES[tex_num]
                        local scaling = (draw_end_y - draw_start_y) / texture_size
                        local quad = love.graphics.newQuad(tex_x, 0, 1, texture_size, texture_size, texture_size)

                        love.graphics.setColor(shading, shading, shading)
                        love.graphics.draw(sprite_texture.img, quad, stripe, draw_start_y, 0, 1, scaling)
                        love.graphics.setColor(1, 1, 1)
                    end
                end
            end
        end
    end
}

return raycaster
