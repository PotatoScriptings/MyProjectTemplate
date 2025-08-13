--[[
    Date of Creation: DD/MM/YYYY (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles saving things in and fetching things from datastores.
]]

-- Services
local DataStoreService = game:GetService("DataStoreService")

local DataStores = {}

-- Function to fetch datastore info
function DataStores.GetDataStoreInfo(Name, Id)
    -- Gets DataStore
    local DataStore = DataStoreService:GetDataStore(Name)
    local Info

    -- Gets info
    local succ, err = pcall(function()
        Info = DataStore:GetAsync(Id)
    end)
    if not succ then
        warn("Failed to get value in DataStore:", err)
    end

    if Info == "N/A" then
        return
    end

    return Info
end

-- Function to save something in a datastore
function DataStores:SetValue(Name, Id, Value)
    -- Gets DataStore
    local DataStore = DataStoreService:GetDataStore(Name)

    -- Adds value
    local succ, err = pcall(function()
        DataStore:SetAsync(Id, Value)
    end)
    if not succ then
        warn("Failed to set value in DataStore:", err)
    end
end

-- Function to wipe datastore
function DataStores:WipeDataStore(Name, Id)
    -- Gets DataStore
    local DataStore = DataStoreService:GetDataStore(Name)

    -- Wipes DataStore
    local succ, err = pcall(function()
        DataStore:SetAsync(Id, "N/A")
    end)
    if not succ then
        warn("Failed to wipe DataStore:", err)
    end
end

return DataStores