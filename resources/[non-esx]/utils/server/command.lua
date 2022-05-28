local ESX

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- /Twt

RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Twitter', ''..name..'', ''..msg..'', 'CHAR_STRETCH', 0)
        end
    end
end, false)

-- /Ano

RegisterCommand('ano', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Anonyme', '', ''..msg..'', 'CHAR_ARTHUR', 0)
        end
    end
end, false)


RegisterCommand('annonce', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(9)
	local args = msg
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group == "superadmin" then
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Annonce', ''..name..'', ''..msg..'', 'CHAR_SOCIAL_CLUB', 2)
        end
    end
end
end, false)


RegisterCommand('tpa', function(source, args, rawCommand)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group == "superadmin" or group == "admin" then
    if player ~= false then
        TriggerClientEvent('rAdminCommand:tpa', args[1], args[2])
    end
end
end, false)