local player = {
    x = 13,
    y = 13,
    dir_x = -1,
    dir_y = 0,
    plane_x = 0,
    plane_y = 0.66,
    move_speed = 0.05,
    cam_speed = 0.075,
    keybinds = {
        fward = "w",
        bward = "s",
        strafe_l = "a",
        strafe_r = "d",
        look_l = "left",
        look_r = "right",
        inv = "tab",
    },
    -- Update function for handling things such as player movement and interactions
    -- map is the map object
    update = function(self, map)
        -- Forwards and back
        if love.keyboard.isDown(self.keybinds.fward) then
            if map.walls[math.floor(self.y)][math.floor(self.x + self.dir_x * self.move_speed)][1] == 0 then
                self.x = self.x + self.dir_x * self.move_speed
            end
            if map.walls[math.floor(self.y + self.dir_y * self.move_speed)][math.floor(self.x)][1] == 0 then
                self.y = self.y + self.dir_y * self.move_speed
            end
        end
        if love.keyboard.isDown(self.keybinds.bward) then
            if map.walls[math.floor(self.y)][math.floor(self.x - self.dir_x * self.move_speed)][1] == 0 then
                self.x = self.x - self.dir_x * self.move_speed
            end
            if map.walls[math.floor(self.y - self.dir_y * self.move_speed)][math.floor(self.x)][1] == 0 then
                self.y = self.y - self.dir_y * self.move_speed
            end
        end
        -- Left and right
        if love.keyboard.isDown(self.keybinds.strafe_l) then
            if map.walls[math.floor(self.y)][math.floor(self.x - self.plane_x * self.move_speed)][1] == 0 then
                self.x = self.x - self.plane_x * (self.move_speed / 2)
            end
            if map.walls[math.floor(self.y - self.plane_y * self.move_speed)][math.floor(self.x)][1] == 0 then
                self.y = self.y - self.plane_y * (self.move_speed / 2)
            end
        end
        if love.keyboard.isDown(self.keybinds.strafe_r) then
            if map.walls[math.floor(self.y)][math.floor(self.x + self.plane_x * self.move_speed)][1] == 0 then
                self.x = self.x + self.plane_x * (self.move_speed / 2)
            end
            if map.walls[math.floor(self.y + self.plane_y * self.move_speed)][math.floor(self.x)][1] == 0 then
                self.y = self.y + self.plane_y * (self.move_speed / 2)
            end
        end

        -- Look left and right
        if love.keyboard.isDown(self.keybinds.look_l) then
            local old_dir_x = self.dir_x
            self.dir_x = self.dir_x * math.cos(self.cam_speed) - self.dir_y * math.sin(self.cam_speed)
            self.dir_y = old_dir_x * math.sin(self.cam_speed) + self.dir_y * math.cos(self.cam_speed)

            local old_plane_x = self.plane_x
            self.plane_x = self.plane_x * math.cos(self.cam_speed) - self.plane_y * math.sin(self.cam_speed)
            self.plane_y = old_plane_x * math.sin(self.cam_speed) + self.plane_y * math.cos(self.cam_speed)
        end
        if love.keyboard.isDown(self.keybinds.look_r) then
            local old_dir_x = self.dir_x
            self.dir_x = self.dir_x * math.cos(-self.cam_speed) - self.dir_y * math.sin(-self.cam_speed)
            self.dir_y = old_dir_x * math.sin(-self.cam_speed) + self.dir_y * math.cos(-self.cam_speed)

            local old_plane_x = self.plane_x
            self.plane_x = self.plane_x * math.cos(-self.cam_speed) - self.plane_y * math.sin(-self.cam_speed)
            self.plane_y = old_plane_x * math.sin(-self.cam_speed) + self.plane_y * math.cos(-self.cam_speed)
        end
    end,
    -- Function for drawing the players hands/weapons etc.
    draw = function(self)

    end
}

return player
