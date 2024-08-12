local objects = {
    -- Creates an object then inserts it into the table passed in
    -- table is the target table
    -- name is the strign name of the object
    -- x,y is coords of where it will spawn
    -- texture is the position of the texture in the sprite texture table
    -- props is a table of any additional properties
    create_obj = function(self, table, name, x, y, texture, props)
        local obj = {
            name = name,
            x = x,
            y = y,
            texture = texture,
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

            table.insert(table, obj)
        end
    end
}

return objects
