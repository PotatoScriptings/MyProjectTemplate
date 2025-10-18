--[[
    Date of Creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles miscellaneous utility functions.
]]

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local modules = ReplicatedStorage.Modules
local infoModules = modules.InfoModules
local utilityModules = modules.UtilityModules

local typesToValues = require(infoModules:WaitForChild("TypesToValues"))

local Utility = {}

-- Function to convert type to value
function Utility.typeToValue(value : any, name : string?, parent : any?) : Instance?
    -- Gets the value type
    local valueType = typesToValues[typeof(value)]
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
            Utility.typeToValue(currentValue, currentName, newValue)
        end
    end

    return newValue
end

return Utility