--TODO:
-- Add a scaling factor to objs and use that to scale sprites in the raycasting code

local objects = {
    -- Creates an object then inserts it into the table passed in
    -----------------------------
    ---@param name string,
    ---@param y number,
    ---@param x number,
    ---@param texture number,
    ---@param x_scaling number,
    ---@param y_scaling number,
    ---@param props table,
    ---@return obj table
    create_obj = function(self, name, y, x, texture, x_scaling, y_scaling, props)
        local obj = {
            name = name,
            x = x,
            y = y,
            texture = texture,
            x_scaling = x_scaling,
            y_scaling = y_scaling,
            distance = 0,
            update = function(self)
            end,
            draw = function(self)
            end,
        }

        if props then
            -- add extra properties to the obj table
            for k, v in pairs(props) do
                obj[k] = v
            end
        end

        return obj
    end
}

return objects
