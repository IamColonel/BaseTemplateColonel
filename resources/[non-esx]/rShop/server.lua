local ESX

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('rShop:buyItemShop')
AddEventHandler('rShop:buyItemShop', function(name, price, mode)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local getItemLabel = ESX.GetItemLabel(name)
    local getCash = xPlayer.getMoney()
    local getBank = xPlayer.getAccount('bank').money
    if mode == "liquide" then
        if getCash >= price then
            xPlayer.addInventoryItem(name, 1)
            xPlayer.removeMoney(price)
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Shop', '', "Vous venez d'acheter ~y~"..getItemLabel.."~s~ pour "..price.."$\n\nMode de paiement : ~r~Liquide", 'CHAR_DREYFUSS', 9)
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Shop', '', 'Vous n\'avez assez ~r~d\'argent', 'CHAR_DREYFUSS', 9)
        end
    elseif mode == "banque" then
        if getBank >= price then
            xPlayer.addInventoryItem(name, 1)
            xPlayer.removeAccountMoney('bank', price)
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Shop', '', "Vous venez d'acheter ~y~"..getItemLabel.."~s~ pour "..price.."$\n\nMode de paiement : ~r~Banque", 'CHAR_DREYFUSS', 9)
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Shop', '', 'Vous n\'avez assez ~r~d\'argent', 'CHAR_DREYFUSS', 9)
        end
    end
end)


RegisterServerEvent('rShop:buyItemShopTech')
AddEventHandler('rShop:buyItemShopTech', function(name, price, mode)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local getItemLabel = ESX.GetItemLabel(name)
    local getCash = xPlayer.getMoney()
    local getBank = xPlayer.getAccount('bank').money
    if mode == "liquide" then
        if getCash >= price then
            xPlayer.addInventoryItem(name, 1)
            xPlayer.removeMoney(price)
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Digital Den', '', "Vous venez d'acheter ~y~"..getItemLabel.."~s~ pour "..price.."$\n\nMode de paiement : ~r~Liquide", 'CHAR_DREYFUSS', 9)
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Digital Den', '', 'Vous n\'avez assez ~r~d\'argent', 'CHAR_DREYFUSS', 9)
        end
    elseif mode == "banque" then
        if getBank >= price then
            xPlayer.addInventoryItem(name, 1)
            xPlayer.removeAccountMoney('bank', price)
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Digital Den', '', "Vous venez d'acheter ~y~"..getItemLabel.."~s~ pour "..price.."$\n\nMode de paiement : ~r~Banque", 'CHAR_DREYFUSS', 9)
        else
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Digital Den', '', 'Vous n\'avez assez ~r~d\'argent', 'CHAR_DREYFUSS', 9)
        end
    end
end)