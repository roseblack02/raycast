-- TODO:
-- Fix the issue where the corners of the tiles around the doors are not drawn (may need to seperate door/flatwall drawing code)
-- Variable height walls would be really nice
-- Add a scaling factor to objs and use that to scale sprites

local raycaster = {
    -- Storing wall distance
    -- Calculate itersection of diagonal walls
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

    -- Initialise the z buffer to be a table with the screens width
    init_z_buffer = function(self, z_buffer, screen_width)
        for i = 1, screen_width do
            table.insert(z_buffer, 999)
        end
    end,

    -- Draw the skybox image and wrap it around the player
    draw_skybox = function(self, player, map)
        local skybox_tex = SKYBOX_TEXTURES[map.skybox_tex]
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
    end,

    --Draw floors and ceilings based on their respective tables in the map
    draw_floors = function(self, player, map, pixel_buffer, texture_size, screen_width, screen_height)
        local half_screen_height = screen_height / 2
        local pos_z = 0.5 * screen_height -- Reference distance for perspective projection

        for y = half_screen_height, screen_height - 1 do
            local p = y - half_screen_height             -- Vertical position relative to the center
            local row_dist = pos_z / (p ~= 0 and p or 1) -- Avoid division by zero

            local inv_screen_width = 1 / screen_width
            local player_dir_plane_x = player.dir_x + player.plane_x
            local player_dir_plane_y = player.dir_y + player.plane_y

            local floor_step_x = row_dist * (player_dir_plane_x - (player.dir_x - player.plane_x)) * inv_screen_width
            local floor_step_y = row_dist * (player_dir_plane_y - (player.dir_y - player.plane_y)) * inv_screen_width
            local floor_x = player.x + row_dist * (player.dir_x - player.plane_x)
            local floor_y = player.y + row_dist * (player.dir_y - player.plane_y)

            if row_dist < map.max_view_dist then
                for x = 0, screen_width - 1 do
                    -- Get position
                    local cell_x = math.abs(math.floor(floor_x))
                    local cell_y = math.abs(math.floor(floor_y))

                    if cell_x > 0 and cell_x < map.width
                        and cell_y > 0 and cell_y < map.height then
                        local floor_tex = map.floors[cell_y][cell_x]
                        local ceiling_tex = map.ceilings[cell_y][cell_x]

                        -- Texture coordinates and clamp them
                        local tx = math.floor(texture_size * (floor_x - cell_x)) % texture_size
                        local ty = math.floor(texture_size * (floor_y - cell_y)) % texture_size
                        tx = math.max(0, math.min(tx, texture_size - 1))
                        ty = math.max(0, math.min(ty, texture_size - 1))

                        -- Calculate shading based on distance
                        local shading = 1 - (row_dist / (map.max_view_dist / 1.5))

                        if y > 0 and y < screen_height then
                            -- Floor
                            if floor_tex > 0 then
                                local r, g, b, a = FLOOR_TEXTURES[floor_tex].img:getPixel(tx, ty)
                                r, g, b = r * shading, g * shading, b * shading

                                if a == 1 then
                                    pixel_buffer:setPixel(x, y, r, g, b)
                                end
                            end

                            -- Ceiling
                            if ceiling_tex > 0 then
                                local r, g, b, a = FLOOR_TEXTURES[ceiling_tex].img:getPixel(tx, ty)
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

    -- Draw walls based on the wall table in the map
    draw_walls = function(self, z_buffer, player, map, texture_size, screen_width, screen_height)
        local half_screen_height = screen_height / 2
        for x = 1, #z_buffer do
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
                    wall_x = player.y + perp_wall_dist * ray_dir_y
                else
                    wall_x = player.x + perp_wall_dist * ray_dir_x
                end
                wall_x = wall_x - math.floor(wall_x)
            end

            -- Drawing walls --
            if map.walls[map_y][map_x][1] > 0 then
                -- Calculate the height of the wall slice
                local line_height = math.floor(screen_height / perp_wall_dist) + 1
                local draw_start = (-line_height / 2 + half_screen_height)
                local draw_end = line_height / 2 + half_screen_height

                -- Calculate shading based on distance
                local shading = 1 - (perp_wall_dist / (map.max_view_dist / 1.5))

                -- Calculate wall texture coordinates based on side
                local tex_x = math.floor(wall_x * texture_size)
                if side == 0 and ray_dir_x > 0 then
                    tex_x = texture_size - tex_x - 1
                end
                if side == 1 and ray_dir_y < 0 then
                    tex_x = texture_size - tex_x - 1
                end

                local wall_texture = WALL_TEXTURES[map.walls[map_y][map_x][1]]
                local scaling = (draw_end + 1 - draw_start) / texture_size
                local quad = love.graphics.newQuad(tex_x, 0, 1, texture_size, texture_size, texture_size)

                z_buffer[x] = perp_wall_dist

                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1, scaling)
                love.graphics.setColor(1, 1, 1)
            end
        end
        return z_buffer
    end,

    -- Draw the sprites found in the sprite objects table
    draw_sprites = function(self, z_buffer, player, map, sprite_objs, texture_size, screen_width, screen_height)
        local half_screen_width = screen_width / 2
        local half_screen_height = screen_height / 2

        -- Get distance from player for each object and sort in reverse order before they are drawn
        for i = 1, #sprite_objs do
            sprite_objs[i].distance = ((player.x - sprite_objs[i].x) ^ 2) + ((player.y - sprite_objs[i].y) ^ 2)
        end
        table.sort(sprite_objs, function(a, b) return a.distance > b.distance end)

        for spr = 1, #sprite_objs do
            -- Only draw sprite if the distance is with the max view distance
            if sprite_objs[spr].distance < map.max_spr_dist then
                -- Get x position relative to the player
                local sprite_x = sprite_objs[spr].x - player.x
                local sprite_y = sprite_objs[spr].y - player.y

                -- Transform sprite with the inverse camera matrix
                local inv_det = 1 / (player.plane_x * player.dir_y - player.dir_x * player.plane_y)
                local transform_x = inv_det * (player.dir_y * sprite_x - player.dir_x * sprite_y)
                local transform_y = inv_det * (-player.plane_y * sprite_x + player.plane_x * sprite_y)

                -- Screen position
                local sprite_screen_x = math.floor((half_screen_width) * (1 + transform_x / transform_y))

                -- Line height
                local sprite_height = math.abs(math.floor(screen_height / (transform_y)))
                local draw_start_y = (-sprite_height / 2 + half_screen_height) -
                    ((sprite_height / 2) * (sprite_objs[spr].y_scaling / 2))
                local draw_end_y = sprite_height / 2 + half_screen_height

                -- Texture width
                local sprite_width = math.abs(math.floor(screen_width / (transform_y))) * sprite_objs[spr].x_scaling
                local draw_start_x = math.floor(-sprite_width / 2 + sprite_screen_x)
                local draw_end_x = math.floor(sprite_width / 2 + sprite_screen_x)

                -- Calculate shading based on distance
                local shading = 1 - (transform_y / (map.max_view_dist / 1.5))
                local tex_num = sprite_objs[spr].texture

                for stripe = draw_start_x, draw_end_x do
                    -- Check if the sprite should be visible before drawing
                    if stripe > 0 and stripe < #z_buffer and z_buffer[stripe]
                        and transform_y < (z_buffer[stripe] or math.huge) and transform_y > 0 then
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
    end,

    -- Render everything to the screen
    raycasting = function(self, player, sprite_objs, map, screen_width, screen_height)
        local texture_size = 128 -- Size of textures but should be using texture.size idealy

        -- Create image data to store the pixel data so floors and ceiling can all be drawn with one draw function
        local pixel_buffer = love.image.newImageData(screen_width, screen_height)
        local z_buffer = {}
        self:init_z_buffer(z_buffer, screen_width)

        if map.skybox then
            self:draw_skybox(player, map)
        end

        pixel_buffer = self:draw_floors(player, map, pixel_buffer, texture_size, screen_width, screen_height)
        local final_frame = love.graphics.newImage(pixel_buffer)
        love.graphics.draw(final_frame)

        z_buffer = self:draw_walls(z_buffer, player, map, texture_size, screen_width, screen_height)
        self:draw_sprites(z_buffer, player, map, sprite_objs, texture_size, screen_width, screen_height)
    end
}

return raycaster
