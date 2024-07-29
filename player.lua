PLAYER = {
    x = 4,
    y = 8,
    dir_x = -1,
    dir_y = 0,
    plane_x = 0,
    plane_y = 0.66,
    move_speed = 0.05,
    cam_speed = 0.075,
    update = function(self, map, dt)
        -- Forwards and back
        if love.keyboard.isDown("w") then
            if map.walls[math.floor(self.y)][math.floor(self.x + self.dir_x * self.move_speed)] == 0 then
                self.x = self.x + self.dir_x * self.move_speed
            end
            if map.walls[math.floor(self.y + self.dir_y * self.move_speed)][math.floor(self.x)] == 0 then
                self.y = self.y + self.dir_y * self.move_speed
            end
        end
        if love.keyboard.isDown("s") then
            if map.walls[math.floor(self.y)][math.floor(self.x - self.dir_x * self.move_speed)] == 0 then
                self.x = self.x - self.dir_x * self.move_speed
            end
            if map.walls[math.floor(self.y - self.dir_y * self.move_speed)][math.floor(self.x)] == 0 then
                self.y = self.y - self.dir_y * self.move_speed
            end
        end
        -- Left and right
        if love.keyboard.isDown("a") then
            if map.walls[math.floor(self.y)][math.floor(self.x - self.plane_x * self.move_speed)] == 0 then
                self.x = self.x - self.plane_x * (self.move_speed / 2)
            end
            if map.walls[math.floor(self.y - self.plane_y * self.move_speed)][math.floor(self.x)] == 0 then
                self.y = self.y - self.plane_y * (self.move_speed / 2)
            end
        end
        if love.keyboard.isDown("d") then
            if map.walls[math.floor(self.y)][math.floor(self.x + self.plane_x * self.move_speed)] == 0 then
                self.x = self.x + self.plane_x * (self.move_speed / 2)
            end
            if map.walls[math.floor(self.y + self.plane_y * self.move_speed)][math.floor(self.x)] == 0 then
                self.y = self.y + self.plane_y * (self.move_speed / 2)
            end
        end

        -- Look left and right
        if love.keyboard.isDown("k") then
            local old_dir_x = self.dir_x
            self.dir_x = self.dir_x * math.cos(self.cam_speed) - self.dir_y * math.sin(self.cam_speed)
            self.dir_y = old_dir_x * math.sin(self.cam_speed) + self.dir_y * math.cos(self.cam_speed)

            local old_plane_x = self.plane_x
            self.plane_x = self.plane_x * math.cos(self.cam_speed) - self.plane_y * math.sin(self.cam_speed)
            self.plane_y = old_plane_x * math.sin(self.cam_speed) + self.plane_y * math.cos(self.cam_speed)
        end
        if love.keyboard.isDown(";") then
            local old_dir_x = self.dir_x
            self.dir_x = self.dir_x * math.cos(-self.cam_speed) - self.dir_y * math.sin(-self.cam_speed)
            self.dir_y = old_dir_x * math.sin(-self.cam_speed) + self.dir_y * math.cos(-self.cam_speed)

            local old_plane_x = self.plane_x
            self.plane_x = self.plane_x * math.cos(-self.cam_speed) - self.plane_y * math.sin(-self.cam_speed)
            self.plane_y = old_plane_x * math.sin(-self.cam_speed) + self.plane_y * math.cos(-self.cam_speed)
        end
    end,
    draw = function(self)

    end
}
