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
local utilityModules = modules.UtilityModules

local loadHandler = require(utilityModules:WaitForChild("LoadHandler"))
local data = loadHandler.getInfo("Data")
local utility = loadHandler.getModule("Utility")

local playerDataStore = DatastoreService:GetDataStore("playerData")

local entityIndex = 0

local DataHandler = {}

-- Creates components
local components = {}
components["Player"] = {}

for name, value in data do
    components[name] = {}
end

-- Function to get an id from player
local function getIdFromPlayer(player : Player) : number
    return table.find(components["Player"], player)
end

-- Function to get a player from id
local function getPlayerFromId(Id : number) : Player
    return components["Player"][Id]
end

-- Function to create new entity
local function createEntity() : number
    entityIndex += 1
    local id = entityIndex
    return id
end

-- Function to set a component
local function setComponent(id : number, componentName : string, value : any)
    local currentComponent = components[componentName]
    if not currentComponent then
        return
    end

    currentComponent[id] = value

    -- Creates new value in player values
    local player = getPlayerFromId(id)
    if not player then
        return
    end
    local playerValues : Folder = player:FindFirstChild("Values")
    local newValue = utility.typeToValue(value, componentName, playerValues)
    if not newValue then
        return
    end

    -- When value changes update component
    local valueChangedConnection
    valueChangedConnection = newValue:GetPropertyChangedSignal("Value"):Connect(function()
        currentComponent[id] = newValue.Value
    end)

    newValue.Destroying:Once(function()
        valueChangedConnection:Disconnect()
    end)
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

    -- Creates player values
    local playerValues = Instance.new("Folder")
    playerValues.Name = "Values"
    playerValues.Parent = player

    -- Sets components
    setComponent(id, "Player", player)
    if playerData then
        for name, value in playerData do
            setComponent(id, name, value)
        end
    else
        for name, value in data do
            setComponent(id, name, value)
        end
    end
end)

-- When a player leaves
Players.PlayerRemoving:Connect(function(player)
    -- Saves player data
    local playerData = DataHandler.getPlayerData(player)

    playerDataStore:SetAsync(player.UserId, playerData)
end)

return DataHandler