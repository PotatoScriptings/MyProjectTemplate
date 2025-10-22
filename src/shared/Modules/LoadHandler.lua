--[[
    Date of Creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles loading modules and info.
]]

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local modules = ReplicatedStorage.Modules
local infoModules = modules.InfoModules
local utilityModules = modules.UtilityModules

local LoadHandler = {}

-- Function to load info
function LoadHandler.loadInfo(infoName : string) : {}
    local infoModule = infoModules:WaitForChild(infoName)

    if infoModule then
        return require(infoModule)
    end
end

-- Function to load module
function LoadHandler.loadModule(moduleName : string) : {}
    local module = utilityModules:WaitForChild(moduleName)

    if infoModules then
        return require(module)
    end
end

-- Function to initialize modules
function LoadHandler.initialize()
    for _, module in utilityModules do
        require(module)
    end
end

return LoadHandler