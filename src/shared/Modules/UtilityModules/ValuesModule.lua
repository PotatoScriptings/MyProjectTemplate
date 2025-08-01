--[[
    Date of Creation: 01/08/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles value-related things like giving players values.
]]

local module = {}

-- Function to give values to an object
function module.GiveValues(Object, Values)
    -- Creates values folder
    local ValuesFolder = Object:FindFirstChild("Values")
    if not ValuesFolder then
        ValuesFolder = Instance.new("Folder")
        ValuesFolder.Name = "Values"
        ValuesFolder.Parent = Object
    end

    -- Loops through values
    for Num, Value in pairs(Values) do
        -- Creates new value
        local NewValue = Instance.new(Value.Type)
        NewValue.Parent = ValuesFolder

        if Value.Value ~= nil then
            NewValue.Value = Value.Value
        end
        
        NewValue.Name = Value.Name or ("Value" .. tostring(Num))
    end
end

return module