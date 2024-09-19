if Config.Framework == "qb" then
    Core = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    Core = exports['es_extended']:getSharedObject()
elseif Config.Framework == "nd" then
    Core = exports['nd-core']:getSharedObject()
elseif Config.Framework == "qbox" then
    Core = exports['qbox-core']:getCoreObject()
end

exports("GetPlayerJob", function()
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayerData().job.name
    elseif Config.Framework == "esx" then
        return Core.GetPlayerData().job.name
    end
    return nil
end)

exports("GetPlayerCitizenID", function(text, duration)
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayerData().citizenid
    elseif Config.Framework == "esx" then
        return Core.GetPlayerData().license
    end
    return nil
end)