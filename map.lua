MAP = {
    width = 16,
    height = 16,
    wall_height = 400,
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
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
        { 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12 },
        { 12, 1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, 12 },
    },
    draw_walls = function(self, player)
        for y = 0, SCREEN_HEIGHT do
            if y < SCREEN_HEIGHT / 2 then
                local r =
                    love.graphics.setColor(0.5 - (y / 500), 0.25 - (y / 500), 0.5 - (y / 500))
                love.graphics.line(0, y, SCREEN_WIDTH, y)
            end
            if y >= SCREEN_HEIGHT / 2 then
                love.graphics.setColor(0, 0 + (y / 750) * 0.25, 0 + (y / 750) * 0.25)
                love.graphics.line(0, y, SCREEN_WIDTH, y)
            end
        end

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

            local view_dist, max_view_dist = 0, 16

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

                if map_x < 0 or map_x >= self.width
                    or map_y < 0 or map_y >= self.height
                    or self.walls[map_y][map_x] > 0 then
                    view_dist = max_view_dist
                end
            end

            if side == 0 then
                perp_wall_dist = (side_dist_x - delta_dist_x)
            else
                perp_wall_dist = (side_dist_y - delta_dist_y)
            end

            local line_height = math.floor(SCREEN_HEIGHT / perp_wall_dist)
            local draw_start = -line_height / 2 + SCREEN_HEIGHT / 2
            local draw_end = line_height / 2 + SCREEN_HEIGHT / 2

            if self.walls[map_y][map_x] > 1 then
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

                -- local wall_col = colours[self.walls[map_y][map_x] - 1]

                -- for i = 1, #wall_col do
                --     wall_col[i] = wall_col[i] - perp_wall_dist / max_view_dist
                -- end

                -- love.graphics.setColor(wall_col)
                -- love.graphics.line(x, draw_start, x, draw_end)

                -- Drawing textures using quads --
                local wall_texture = TEXTURES[self.walls[map_y][map_x] - 1]

                local shading = 1 - (perp_wall_dist / (max_view_dist / 1.5))
                local scaling = (draw_end - draw_start) / wall_texture.size

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

                love.graphics.setColor(shading, shading, shading)
                love.graphics.draw(wall_texture.img, quad, x, draw_start, 0, 1, scaling)
            end
        end
    end
}
