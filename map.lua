MAP = {
    width = 16,
    height = 16,
    walls = {
        { 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
        { 2,  0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2 },
        { 2,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 2 },
        { 2,  0, 0, 5, 5, 0, 0, 2, 0, 0, 0, 0, 2, 2, 2, 2 },
        { 1,  0, 0, 5, 5, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 1 },
        { 6,  0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2 },
        { 7,  0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 3 },
        { 8,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 },
        { 9,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5 },
        { 10, 0, 0, 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 6 },
        { 11, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 7 },
        { 1,  0, 0, 4, 4, 0, 0, 2, 0, 0, 0, 2, 2, 3, 0, 1 },
        { 2,  0, 0, 4, 4, 0, 0, 2, 0, 0, 0, 8, 0, 4, 0, 2 },
        { 2,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 6, 5, 0, 2 },
        { 2,  0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2 },
        { 2,  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 }
    },
    floors = {
        { 2, 2, 2, 2, 2, 2, 2, 2, 2,  2,  2,  2,  2, 2, 2, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 3, 2, 3, 2, 3, 2, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 3, 2, 3, 2, 3, 5, 10, 10, 10, 10, 3, 4, 3, 2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2,  2,  2,  2,  2, 2, 2, 2 }
    },
    ceilings = {
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2,  2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 9, 9, 9, 9, 9, 9,  9,  2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 9, 9, 9, 9, 9, 9,  9,  2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 10, 10, 2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 9, 9, 9, 9, 9, 9,  9,  2 },
        { 2, 7, 7, 7, 7, 7, 7, 7, 9, 9, 9, 9, 9, 9,  9,  2 },
        { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,  2,  2 }
    },

    -- Function to draw the walls and floors on the screen
    draw_walls = function(self, player)
        local max_view_dist = 10 -- Maximum distance to draw the walls
        local texture_size = 128 -- Size of textures but should be using texture.size idealy

        -- Create an image data buffer to store the pixel data
        local pixel_buffer = love.image.newImageData(800, 600)

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
                if self.walls[map_y][map_x] > 0 then
                    view_dist = max_view_dist
                end
            end

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

            local wall_x
            -- Calculate wall texture coordinates based on side
            if side == 0 then
                wall_x = player.y + perp_wall_dist * ray_dir_y
            else
                wall_x = player.x + perp_wall_dist * ray_dir_x
            end
            wall_x = wall_x - math.floor(wall_x)

            local text_x = math.floor(wall_x * texture_size)
            if side == 0 and ray_dir_x > 0 then
                text_x = texture_size - text_x - 1
            end
            if side == 1 and ray_dir_y < 0 then
                text_x = texture_size - text_x - 1
            end

            -- Drawing walls --
            if self.walls[map_y][map_x] > 1 then
                local wall_texture = WALL_TEXTURES[self.walls[map_y][map_x] - 1]
                local scaling = (draw_end - draw_start) / texture_size
                local quad = love.graphics.newQuad(text_x, 0, 1, texture_size, texture_size, texture_size)

                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1, scaling)
                love.graphics.setColor(1, 1, 1)
            end

            -- Drawing floors --
            local floor_x_wall, floor_y_wall
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

            for y = draw_end, SCREEN_HEIGHT do
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
                        local r, g, b = FLOOR_TEXTURE[floor_text].img:getPixel(floor_text_x, floor_text_y)
                        r, g, b = r * floor_shading, g * floor_shading, b * floor_shading
                        pixel_buffer:setPixel(x, y, r, g, b)
                    end

                    if ceiling_text > 0 then
                        local r, g, b = FLOOR_TEXTURE[ceiling_text].img:getPixel(floor_text_x, floor_text_y)
                        r, g, b = r * floor_shading, g * floor_shading, b * floor_shading
                        pixel_buffer:setPixel(x, SCREEN_HEIGHT - y, r, g, b)
                    end
                end
            end
        end

        -- Drawing final image. This is just for floors and ceilings
        local final_frame = love.graphics.newImage(pixel_buffer)
        love.graphics.draw(final_frame)
    end
}
