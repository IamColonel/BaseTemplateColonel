ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('wBarber:Buy')
AddEventHandler('wBarber:Buy', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xMoney = xPlayer.getMoney()
    if xMoney > Barber.Price then
        xPlayer.removeMoney(Barber.Price)
        TriggerClientEvent('esx:showNotification', _src, '~g~Achat effectuer merci à vous !')
        TriggerClientEvent('wBarber:Save', _src)
    else
        TriggerClientEvent('esx:showNotification', _src, '~r~Vous n\'avez pas assez d\'argent sur vous !')
    end
end)