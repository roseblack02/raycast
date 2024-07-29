MAP = {
    width = 16,
    height = 16,
    wall_height = 400,
    walls = { -- {wall, floor, ceiling}
        { { 2, 0, 0 },  { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 },  { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 } },
        { { 2, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 } },
        { { 2, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 } },
        { { 2, 0, 0 },  { 0, 0, 0 }, { 5, 0, 0 }, { 5, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 } },
        { { 1, 0, 0 },  { 0, 0, 0 }, { 5, 0, 0 }, { 5, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 1, 0, 0 } },
        { { 6, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 } },
        { { 7, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 3, 0, 0 } },
        { { 8, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 4, 0, 0 } },
        { { 9, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 5, 0, 0 } },
        { { 10, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 6, 0, 0 } },
        { { 11, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 7, 0, 0 } },
        { { 1, 0, 0 },  { 0, 0, 0 }, { 4, 0, 0 }, { 4, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 10, 0, 0 }, { 3, 0, 0 }, { 4, 0, 0 }, { 0, 0, 0 }, { 1, 0, 0 } },
        { { 2, 0, 0 },  { 0, 0, 0 }, { 4, 0, 0 }, { 4, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 9, 0, 0 },  { 0, 0, 0 }, { 5, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 } },
        { { 2, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 8, 0, 0 },  { 7, 0, 0 }, { 6, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 } },
        { { 2, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 },  { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 }, { 2, 0, 0 } },
        { { 2, 0, 0 },  { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 },  { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 }, { 2, 0, 0 } }
    },
    draw_floors = function(self, player)
        -- Looping vertically instead of horizontally for the floor and ceiling
        local floor_texture = TEXTURES[18]
        local ceiling_texture = TEXTURES[12]

        for y = 0, SCREEN_HEIGHT, 1 do
            local ray_dir_x0 = player.dir_x - player.plane_y
            local ray_dir_y0 = player.dir_y - player.plane_y
            local ray_dir_x1 = player.dir_x + player.plane_y
            local ray_dir_y1 = player.dir_y + player.plane_y

            local pos_y = player.y - SCREEN_HEIGHT / 2

            local pos_z = 0.5 * SCREEN_HEIGHT

            -- Horizontal distance from camera to the floor
            -- Z pos is the middle between floor and ceiling
            local row_dist = pos_z / pos_y

            local floor_step_x = row_dist * (ray_dir_x1 - ray_dir_x0) / SCREEN_WIDTH
            local floor_step_y = row_dist * (ray_dir_y1 - ray_dir_y0) / SCREEN_WIDTH

            local floor_x = player.x + row_dist * ray_dir_x0
            local floor_y = player.y + row_dist * ray_dir_y0

            for x = 0, SCREEN_WIDTH - 1 do
                local cell_X = math.floor(floor_x)
                local cell_y = math.floor(floor_y)

                local tx = math.floor(floor_texture.size * (floor_x - cell_X)) % floor_texture.size
                local ty = math.floor(floor_texture.size * (floor_y - cell_y)) % floor_texture.size

                floor_x = floor_x + floor_step_x
                floor_y = floor_y + floor_step_y

                -- Draw floor
                local floor_quad = love.graphics.newQuad(tx, ty, 1, 1, floor_texture.size, floor_texture.size)
                love.graphics.setColor(1, 1, 1) -- Set color to white
                love.graphics.draw(floor_texture.img, floor_quad, x, y)

                -- Draw ceiling (symmetrical)
                local ceiling_quad = love.graphics.newQuad(tx, ty, 1, 1, ceiling_texture.size, ceiling_texture.size)
                love.graphics.setColor(1, 1, 1) -- Set color to white
                love.graphics.draw(ceiling_texture.img, ceiling_quad, x, SCREEN_HEIGHT - y - 1)
            end
        end
    end,
    draw_walls = function(self, player)
        for x = 0, SCREEN_WIDTH, 2 do
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

            local dof, max_dof = 0, 16

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

            while dof < max_dof do
                if side_dist_x < side_dist_y then
                    side_dist_x = side_dist_x + delta_dist_x
                    map_x = map_x + step_x
                    side = 0
                    dof = dof + 1
                else
                    side_dist_y = side_dist_y + delta_dist_y
                    map_y = map_y + step_y
                    side = 1
                    dof = dof + 1
                end

                if map_x < 0 or map_x >= self.width
                    or map_y < 0 or map_y >= self.height
                    or self.walls[map_y][map_x][1] > 0 then
                    dof = max_dof
                end
            end

            if side == 0 then
                perp_wall_dist = (side_dist_x - delta_dist_x)
            else
                perp_wall_dist = (side_dist_y - delta_dist_y)
            end

            local line_height = math.floor(SCREEN_HEIGHT / perp_wall_dist)

            local draw_start = -line_height / 2 + SCREEN_HEIGHT / 2
            draw_start = math.max(0, draw_start)

            local draw_end = line_height / 2 + SCREEN_HEIGHT / 2
            draw_end = math.min(SCREEN_HEIGHT - 1, draw_end)

            if self.walls[map_y][map_x][1] > 1 then
                -- For drawing colours --
                -- local colours = {
                --     { 1,    0,   0 },
                --     { 1,    0.5, 0 },
                --     { 1,    1,   0 },
                --     { 0,    1,   0 },
                --     { 0,    0,   1 },
                --     { 0.75, 0,   0.75 },
                --     { 1,    0,   0.5 },
                --     { 1,    1,   1 }
                -- }

                -- local wall_col = colours[self.walls[map_y][map_x][1] - 1]

                -- for i = 1, #wall_col do
                --     wall_col[i] = wall_col[i] - perp_wall_dist / max_dof
                -- end

                -- love.graphics.setColor(wall_col)
                -- love.graphics.line(x, draw_start, x, draw_end)

                -- Drawing textures pixel by pixel --
                local wall_texture = TEXTURES[self.walls[map_y][map_x][1] - 1]
                local wall_x
                if side == 0 then
                    wall_x = player.y + perp_wall_dist * ray_dir_y
                else
                    wall_x = player.x + perp_wall_dist * ray_dir_x
                end
                wall_x = wall_x - math.floor(wall_x)

                local tex_x = math.floor(wall_x * wall_texture.size)
                if side == 0 and ray_dir_x > 0 then
                    tex_x = wall_texture.size - tex_x - 1
                end
                if side == 1 and ray_dir_y < 0 then
                    tex_x = wall_texture.size - tex_x - 1
                end

                local quad = love.graphics.newQuad(tex_x, 0, 2, wall_texture.size, wall_texture.size, wall_texture.size)

                local shading = 1 - (perp_wall_dist / (max_dof / 1.5))

                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1,
                    (draw_end - draw_start) / wall_texture.size)
            end
        end
    end
}
