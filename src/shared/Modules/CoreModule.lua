--[[
    Date of creation: DD/MM/YYYY (DD/MM/YYYY)
    Author: Potato
    Purpose: This module is used to show what is enabled and what isn't. This can be used later to check if something is enabled or not.
]]

local CoreModule = {}

-- Core Module Structure Template (Delete later)
CoreModule["StructureTemplate"] = {
    Enabled = true, -- If the core is enabled

    Client = {
        Enabled = true, -- If the client side of the core is enabled

        -- Add more client specific settings here
    },
    Server = {
        Enabled = true, -- If the server side of the core is enabled

        -- Add more server specific settings here
    },
}

return CoreModule