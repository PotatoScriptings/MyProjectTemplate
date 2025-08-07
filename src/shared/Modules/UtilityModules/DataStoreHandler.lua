--[[
    Date of Creation: DD/MM/YYYY (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles saving things in and fetching things from datastores.
]]

-- Services
local DataStoreService = game:GetService("DataStoreService")

local DataStores = {}

-- Function to create a datastore
function DataStores.new(Name, Id, Value)
    -- Creates DataStore
    local NewDatastore = DataStoreService:GetDataStore(Name)

    DataStores[Name] = NewDatastore

    -- Adds value
    if Value then
        local succ, err = pcall(function()
            NewDatastore:SetAsync(Id, Value)
        end)
        if not succ then
            warn("Failed to set value in DataStore:", err)
        end
    end

    return NewDatastore
end

-- Function to fetch datastore info
function DataStores.GetDataStoreInfo(Name, Id)
    -- Gets DataStore
    local DataStore = DataStores[Name]
    local Info

    -- Adds value
    local succ, err = pcall(function()
        Info = DataStore:GetAsync(Id)
    end)
    if not succ then
        warn("Failed to set value in DataStore:", err)
    end

    return Info
end

-- Function to save something in a datastore
function DataStores:SetValue(Name, Id, Value)
    -- Gets DataStore
    local DataStore = DataStores[Name]

    -- Adds value
    local succ, err = pcall(function()
        DataStore:SetAsync(Id, Value)
    end)
    if not succ then
        warn("Failed to set value in DataStore:", err)
    end
end

return DataStores