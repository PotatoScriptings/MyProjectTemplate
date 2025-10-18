--[[
    Date of Creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles registering and calling remote events.
]]

-- Variables
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local RemotesHandler = {}

-- Function to register a remote event or function
function RemotesHandler.registerRemote(remoteName : string, eventType : "RemoteEvent" | "RemoteFunction"?) : RemoteEvent | RemoteFunction
    local newRemote = Instance.new(eventType or "RemoteEvent")
    newRemote.Name = remoteName
    newRemote.Parent = Remotes
    return newRemote
end

-- Function to call a remote event or function
function RemotesHandler.callRemote(remoteName : string, targetPlayer : Player?, ...)
    local remote = Remotes:FindFirstChild(remoteName)
    if not remote then
        remote = RemotesHandler.registerRemote(remoteName)
    end

    if remote:IsA("RemoteEvent") then
        if targetPlayer then
            remote:FireClient(targetPlayer, ...)
        else
            remote:FireServer(...)
        end
    else
        if targetPlayer then
            remote:InvokeClient(targetPlayer, ...)
        else
            remote:InvokeServer(...)
        end
    end
end

return RemotesHandler