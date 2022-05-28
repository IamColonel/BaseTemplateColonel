  
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('rCarteSim:Getlescartesim', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll(
      'SELECT * FROM user_sim WHERE identifier = @identifier',
      {
          ['@identifier'] = xPlayer.identifier
      },
      function(result)
  
        cb(result)
    end)
end)


ESX.RegisterServerCallback('rCarteSim:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items = xPlayer.getInventoryItem(item)
    if items == nil then
        cb(0)
    else
        cb(items.count)
    end
end)


RegisterServerEvent('rCarteSim:SetNumber')
AddEventHandler('rCarteSim:SetNumber', function(numb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  phoneNumber = numb
  TriggerClientEvent("gcPhone:myPhoneNumber",_source,numb)
  TriggerClientEvent("dqP:UpdateNumber",_source,numb)
  
  MySQL.Async.execute(
      'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
      {
          ['@identifier']   = xPlayer.identifier,
          ['@phone_number'] = phoneNumber
      }
  )
    TriggerClientEvent('esx:showNotification', _source, "Numéro utilisé : "..tostring(phoneNumber))
end)


RegisterServerEvent('rCarteSim:Supprimer')
AddEventHandler('rCarteSim:Supprimer', function(number)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
        MySQL.Async.execute(
            'UPDATE users SET phone_number = @phone_number WHERE identifier = @identifier',
            {
                ['@identifier']   = xPlayer.identifier,
                ['@phone_number'] = nil
    
            }
        )
    TriggerClientEvent("gcPhone:myPhoneNumber",_source,nil)
    TriggerClientEvent("dqP:UpdateNumber",_source,nil)
			
    MySQL.Async.execute(
        'DELETE FROM user_sim WHERE identifier = @identifier AND number = @number ',
        {
            ['@identifier']   = xPlayer.identifier,
            ['@number'] = number

        }
    )
  TriggerClientEvent('esx:showNotification', source, "Vous avez détruit la carte SIM : "..number)
end)


RegisterServerEvent("rCarteSim:RenameSim")
AddEventHandler("rCarteSim:RenameSim", function(id, txt, num)
  MySQL.Async.execute(
    'UPDATE user_sim SET label = @label WHERE id=@id',
    {
      ['@id'] = id,
      ['@label'] = txt

    }
  )
  TriggerClientEvent('esx:showNotification', source, "Vous avez renommer la carte SIM : "..num.." par "..txt)
end)
