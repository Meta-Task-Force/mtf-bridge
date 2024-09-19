local Core = nil
local ox_inventory = nil

if Config.Inventory == 'ox' then 
    ox_inventory = exports.ox_inventory
end

if Config.Framework == "qb" then
    Core = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    Core = exports['es_extended']:getSharedObject()
elseif Config.Framework == "nd" then
    Core = exports['nd-core']:getSharedObject()
elseif Config.Framework == "qbox" then
    Core = exports['qbox-core']:getCoreObject()
end

-- Exportable functions
exports("GetPlayer", function(src)
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayer(src)
    elseif Config.Framework == "esx" then
        return ESX.GetPlayerFromId(src)
    end
    return nil
end)

exports("GetPlayerName", function(src)
    local Player = exports['mtf-bridge']:GetPlayer(src)
    if Config.Framework == 'qb' then
        return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    elseif Config.Framework == 'esx' then
        return Player.name
    end
    return false
end)

exports("GetPlayerCitizenID", function(src)
    local Player = exports['mtf-bridge']:GetPlayer(src)
    if Config.Framework == 'qb' then
        return Player.PlayerData.citizenid
    elseif Config.Framework == 'esx' then
        return Player.license
    end
    return false
end)

exports("GetPlayerFromCitizenID", function(citizenid)
    if Config.Framework == 'qb' then
        return QBCore.Functions.GetPlayerByCitizenId(citizenid)
    elseif Config.Framework == 'esx' then
        return ESX.GetPlayerFromIdentifier(citizenid)
    end
    return false
end)

exports("Notify", function(src, message, type, duration)
    if Config.Notify == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, {description = message, duration = duration})
    elseif Config.Notify == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, message, type, duration)
    elseif Config.Notify == 'esx' then 
        TriggerClientEvent('esx:showNotification', src, message, type, duration)
    end
end)

exports("GetPlayerEconomy", function(src, type)
    local Player = exports['mtf-bridge']:GetPlayer(src)
    if Config.Framework == "qb" then
        return Player.PlayerData.money[tostring(type)]
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer.getAccount(type).money
    end
    return 0
end)

exports("AddEconomy", function(src, type, amt)
    local Player = exports['mtf-bridge']:GetPlayer(src)

    if Config.Framework == "qb" then
        Player.Functions.AddMoney(tostring(type), amt)
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.addAccountMoney(type, amt)
    end
end)

exports("RemoveEconomy", function(src, type, amt)
    local Player = exports['mtf-bridge']:GetPlayer(src)
    if Config.Framework == "qb" then
        Player.Functions.RemoveMoney(type, amt)
    elseif Config.Framework == "esx" then
        local xPlayer = ESX.GetPlayerFromId(src)
        xPlayer.removeAccountMoney(type, amt)
    end
end)

exports("AddItem", function(src, item, amt, metadata)
    if Config.Inventory == 'ox' then
        ox_inventory:AddItem(src, item, amt, metadata)
    elseif Config.Inventory == 'qb' then
        local Player = exports['mtf-bridge']:GetPlayer(src)
        Player.Functions.AddItem(item, amt, false, metadata or {})
        TriggerClientEvent("inventory:client:ItemBox", src, Core.Shared.Items[item], "add", amt)
    elseif Config.Inventory == 'esx' then
        local Player = ESX.GetPlayerFromId(src)
        Player.addInventoryItem(item, amt, metadata or {})
    end
end)

exports("RemoveItem", function(src, item, amt, metadata, slot)
    if Config.Inventory == 'ox' then 
        ox_inventory:RemoveItem(src, item, amt, metadata, slot)
    elseif Config.Inventory == 'qb' then
        local Player = exports['mtf-bridge']:GetPlayer(src)
        Player.Functions.RemoveItem(item, amt)
        TriggerClientEvent("inventory:client:ItemBox", src, Core.Shared.Items[item], "remove", amt)
    elseif Config.Inventory == 'esx' then
        local Player = ESX.GetPlayerFromId(src)
        Player.removeInventoryItem(item, amt)
    end
end)

exports("HasItem", function(src, item, amt)
    if Config.Inventory == 'ox' then
        if exports.ox_inventory:GetItem(src, item, nil, true) >= amt then return true else return false end
    elseif Config.Inventory == "qb" then
        local Player = exports['mtf-bridge']:GetPlayer(src)
        local itemData = Player.Functions.GetItemByName(item)

        if itemData and itemData.amount >= amt then 
            return true
        else
            return false
        end
    elseif Config.Inventory == "esx" then
        local Player = ESX.GetPlayerFromId(src)

        
        if Player.hasItem(item) >= amt then 
            return true
        else
            return false
        end
    end
    return false
end)

exports("GetItemCount", function(src, item)
    if Config.Inventory == 'ox' then
        return exports.ox_inventory:GetItem(src, item, nil, true) or 0
    elseif Config.Inventory == "qb" then
        local Player = exports['mtf-bridge']:GetPlayer(src)
        local itemData = Player.Functions.GetItemByName(item)
        return itemData and itemData.amount or 0
    elseif Config.Inventory == "esx" then
        local Player = ESX.GetPlayerFromId(src)
        local itemData = Player.getInventoryItem(item)
        return itemData and itemData.count or 0
    end
    return 0
end)

exports("GetItemSlot", function(src, slot)
    if Config.Inventory == 'ox' then
        return exports.ox_inventory:GetSlot(src, slot)
    elseif Config.Inventory == 'qb' then
        local item = exports['qb-inventory']:GetItemBySlot(src, slot)
        if item then
            return item
        end

    elseif Config.Inventory == 'esx' then 

    end
end)

exports("GetItemByName", function(src, item)
    if Config.Inventory == 'ox' then
        return  exports.ox_inventory:GetSlotIdWithItem(src, item, false)
    elseif Config.Inventory == 'qb' then
        return exports['qb-inventory']:GetItemByName(items, item)
    elseif Config.Inventory == 'esx' then 

    end
end)
