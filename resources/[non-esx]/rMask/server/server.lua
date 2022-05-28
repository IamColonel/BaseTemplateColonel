ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('wMask:Buy')
AddEventHandler('wMask:Buy', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xMoney = xPlayer.getMoney()
    if xMoney > Mask.Price then
        xPlayer.removeMoney(Mask.Price)
        TriggerClientEvent('esx:showNotification', _src, '~g~Achat effectuer merci à vous !')
        TriggerClientEvent('wMask:Save', _src)
    else
        TriggerClientEvent('esx:showNotification', _src, '~r~Vous n\'avez pas assez d\'argent sur vous !')
    end
end)