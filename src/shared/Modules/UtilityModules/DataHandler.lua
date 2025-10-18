--[[
    Date of creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This ECS module handles player data management using DatastoreService.
]]

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DatastoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local modules = ReplicatedStorage.Modules
local infoModules = modules.InfoModules
local utilityModules = modules.UtilityModules

local data = require(infoModules:WaitForChild("Data"))

local playerDataStore = DatastoreService:GetDataStore("playerData")

local entityIndex = 0

local DataHandler = {}

-- Creates components
local components = data["NewPlayer"]

-- Function to create new entity
local function createEntity() : number
    entityIndex += 1
    local id = entityIndex
    return id
end

-- Function to set a component
local function setComponent(id : number, componentName : string, value : any)
    local currentComponent = components[componentName]

    currentComponent[id] = value
end

-- Function to get an id from player
local function getIdFromPlayer(player : Player)
    return table.find(components["Name"], player.Name)
end

-- Function to get a player's data
function DataHandler.getPlayerData(player : Player) : {}
    local id = getIdFromPlayer(player)
    local playerData = {}

    for name, component in components do
        playerData[name] = component[id]
    end

    return playerData
end

-- Function to set a player's data
function DataHandler.setPlayerData(player : Player, targetData : {})
    local id = getIdFromPlayer(player)
    for name, value in targetData do
        setComponent(id, name, value)
    end
end

-- When a player joins
Players.PlayerAdded:Connect(function(player)
    -- Variables
    local id = createEntity()
    local playerData = playerDataStore:GetAsync(player.UserId)

    -- Sets components
    for name, value in playerData do
        setComponent(id, name, value)
    end
end)

-- When a player leaves
Players.PlayerRemoving:Connect(function(player)
    -- Saves player data
    local playerData = DataHandler.getPlayerData(player)

    playerDataStore:SetAsync(player.UserId, playerData)
end)

return DataHandler