--[[
    Date of Creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module includes some types and their value counterparts like number to numbervalue. It can also convert them
]]

local module = {}

module["Info"] = {
    ["number"] = "NumberValue",
    ["string"] = "StringValue",
    ["boolean"] = "BoolValue",
    ["Vector3"] = "Vector3Value",
    ["CFrame"] = "CFrameValue",
    ["table"] = "Folder",
}

-- Function to convert type to value
function module.typeToValue(value : any, name : string?, parent : any?) : Instance?
    -- Gets the value type
    local valueType = module["Info"][typeof(value)]
    if not valueType then
        warn("Unsupported type: " .. typeof(value))
        return
    end

    -- Creates new value
    local newValue = Instance.new(valueType)
    newValue.Value = value
    if name then
        newValue.Name = name
    end
    if parent then
        if parent:FindFirstChild(name) then
            parent:FindFirstChild(name):Destroy()
        end
        newValue.Parent = parent
    end

    -- If value was a table add its contents
    if typeof(value) == "table" then
        for currentName, currentValue in pairs(value) do
            module.typeToValue(currentValue, currentName, newValue)
        end
    end

    return newValue
end

return module