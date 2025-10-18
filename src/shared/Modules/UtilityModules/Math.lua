--[[
    Date of Creation: 18/10/2025 (DD/MM/YYYY)
    Author: Potato
    Purpose: This module handles math utility functions.
]]

local Math = {}

-- Function to get a percentage of two numbers
function Math.getPercentage(num : number, bigNum : number) : number
    return 100 / (bigNum / num)
end

-- Function to get a random chance
function Math.randomChance(percentage : number) : boolean
    local percentageMultiplier = 1
    while percentage < 1 do
        percentage *= 10
        percentageMultiplier *= 10
    end

    local randomNum = math.random(1, 100 * percentageMultiplier)
    return randomNum <= percentage
end

return Math