--[[
    Date of Creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles math utility functions.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local modules = ReplicatedStorage.Modules

local loadHandler = require(modules:WaitForChild("LoadHandler"))
local numberAbbreviations = loadHandler.loadInfo("NumberAbbreviations")

local Math = {}

-- Function to get a percentage of two numbers
function Math.getPercentage(num : number, bigNum : number) : number
    return 100 / (bigNum / num)
end

-- Function to get a random probability
function Math.weightedRandom<index>(weights : {[index] : number}) : index
    local totalWeight = 0
    for _, weight in weights do
        totalWeight += weight
    end

    local finalIndex = nil
    local randomNum = math.random(1, totalWeight)
    local currentWeight = 0
    for index, weight in weights do
        currentWeight += weight
        if randomNum <= currentWeight then
            finalIndex = index
        end
    end

    return finalIndex
end

-- Function to abbreviate number
function Math.abbreviateNumber(number : number) : string
    local newNum = nil
    local numberAbbreviation = nil
    for num, _ in numberAbbreviations do
        if num > number then
            local lastNum = num / 1000
            if numberAbbreviations[lastNum] then
                newNum = number / lastNum
                numberAbbreviation = numberAbbreviations[lastNum]
            end
        end
    end
    if not newNum or not numberAbbreviation then
        return
    end

    local oldNum = newNum
    newNum = math.round(newNum * 10) / 10

    local finalText = newNum .. numberAbbreviation
    if oldNum ~= newNum then
        finalText = finalText .. "+"
    end
    
    return finalText
end

return Math