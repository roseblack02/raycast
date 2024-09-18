local objects = {
    -- Creates an object then inserts it into the table passed in
    -----------------------------
    ---@param name string,
    ---@param y number,
    ---@param x number,
    ---@param textures table,
    ---@param x_scaling number,
    ---@param y_scaling number,
    ---@param is_directional boolean,
    ---@param props table,
    ---@return table obj
    create_obj = function(self, name, y, x, textures, x_scaling, y_scaling, is_directional, props)
        local obj = {
            name = name,
            x = x,
            y = y,
            textures = textures,
            x_scaling = x_scaling,
            y_scaling = y_scaling,
            is_directional = is_directional,
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
