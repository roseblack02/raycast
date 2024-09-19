local Player = {
    x = 5,
    y = 10,
    dir_x = 0.99,
    dir_y = 0,
    dir = 2,
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
        interact = "e",
    },
    -- Update function for handling things such as player movement and interactions
    -----------------------------
    ---@param Map table,
    update = function(self, Map)
        -- Forwards and back
        if love.keyboard.isDown(self.keybinds.fward) then
            if not Map.walls[math.floor(self.y)][math.floor(self.x + self.dir_x * self.move_speed)][3] then
                self.x = self.x + self.dir_x * self.move_speed
            end
            if not Map.walls[math.floor(self.y + self.dir_y * self.move_speed)][math.floor(self.x)][3] then
                self.y = self.y + self.dir_y * self.move_speed
            end
        end
        if love.keyboard.isDown(self.keybinds.bward) then
            if not Map.walls[math.floor(self.y)][math.floor(self.x - self.dir_x * self.move_speed)][3] then
                self.x = self.x - self.dir_x * self.move_speed
            end
            if not Map.walls[math.floor(self.y - self.dir_y * self.move_speed)][math.floor(self.x)][3] then
                self.y = self.y - self.dir_y * self.move_speed
            end
        end
        -- Left and right
        if love.keyboard.isDown(self.keybinds.strafe_l) then
            if not Map.walls[math.floor(self.y)][math.floor(self.x - self.plane_x * self.move_speed)][3] then
                self.x = self.x - self.plane_x * (self.move_speed / 2)
            end
            if not Map.walls[math.floor(self.y - self.plane_y * self.move_speed)][math.floor(self.x)][3] then
                self.y = self.y - self.plane_y * (self.move_speed / 2)
            end
        end
        if love.keyboard.isDown(self.keybinds.strafe_r) then
            if not Map.walls[math.floor(self.y)][math.floor(self.x + self.plane_x * self.move_speed)][3] then
                self.x = self.x + self.plane_x * (self.move_speed / 2)
            end
            if not Map.walls[math.floor(self.y + self.plane_y * self.move_speed)][math.floor(self.x)][3] then
                self.y = self.y + self.plane_y * (self.move_speed / 2)
            end
        end

        -- Look left and right
        if love.keyboard.isDown(self.keybinds.look_l) then
            local old_dir_x = self.dir_x
            self.dir_x = self.dir_x * math.cos(-self.cam_speed) - self.dir_y * math.sin(-self.cam_speed)
            self.dir_y = old_dir_x * math.sin(-self.cam_speed) + self.dir_y * math.cos(-self.cam_speed)

            local old_plane_x = self.plane_x
            self.plane_x = self.plane_x * math.cos(-self.cam_speed) - self.plane_y * math.sin(-self.cam_speed)
            self.plane_y = old_plane_x * math.sin(-self.cam_speed) + self.plane_y * math.cos(-self.cam_speed)

            self:check_direction()
        end
        if love.keyboard.isDown(self.keybinds.look_r) then
            local old_dir_x = self.dir_x
            self.dir_x = self.dir_x * math.cos(self.cam_speed) - self.dir_y * math.sin(self.cam_speed)
            self.dir_y = old_dir_x * math.sin(self.cam_speed) + self.dir_y * math.cos(self.cam_speed)

            local old_plane_x = self.plane_x
            self.plane_x = self.plane_x * math.cos(self.cam_speed) - self.plane_y * math.sin(self.cam_speed)
            self.plane_y = old_plane_x * math.sin(self.cam_speed) + self.plane_y * math.cos(self.cam_speed)

            self:check_direction()
        end

        -- Interact
        if love.keyboard.isDown(self.keybinds.interact) then
            -- Get tile data
            local tile, x, y = self:check_tile(Map)

            -- Check for an event flag
            local flag = tile[4]
            if flag > 0 then
                -- Grab event using the flag and call it
                local fn = Map.events[tile[4]]
                fn(Map, self, x, y)
            end
        end
    end,
    -- Get data of the wall tile in front of the player
    -----------------------------
    ---@param Map table
    check_tile = function(self, Map)
        local y, x = math.floor(self.y + self.dir_y * self.move_speed), math.floor(self.x + self.dir_x * self.move_speed)
        local tile = Map.walls[y][x]
        return tile, x, y
    end,
    -- Function for checking the players direction 1 is north, 2 is east, 3 is south, 4 is west
    -----------------------------
    check_direction = function(self)
        -- note that north and south are flipped e.g. (0,-1) is north
        if self.dir_x < 0.5 and self.dir_x > -0.5 then
            if self.dir_y > 0.5 then
                self.dir = 3
            elseif self.dir_y < -0.5 then
                self.dir = 1
            end
        end
        if self.dir_y < 0.5 and self.dir_y > -0.5 then
            if self.dir_x > 0.5 then
                self.dir = 2
            elseif self.dir_x < -0.5 then
                self.dir = 4
            end
        end
    end,
    -- Function for drawing the players hands/weapons etc.
    -----------------------------
    draw = function(self)

    end
}

return Player
