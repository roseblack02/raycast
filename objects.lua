--TODO:
-- Add a scaling factor to objs and use that to scale sprites in the raycasting code

local objects = {
    -- Creates an object then inserts it into the table passed in
    -- props is a table of any additional properties
    -- distance will be used when sorting sprites
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
