RegisterServerEvent("esx_identity:updatefirstname")
RegisterServerEvent("esx_identity:updatelastname")
RegisterServerEvent("esx_identity:updateheight")
RegisterServerEvent("esx_identity:updatesexxx")
RegisterServerEvent("esx_identity:updatedateofbirth")
RegisterServerEvent("Creator:setPlayerToBucket")
RegisterServerEvent("Creator:setPlayerToNormalBucket")

AddEventHandler("esx_identity:updatefirstname", function(nameInput)
	MySQL.Async.execute("UPDATE users SET firstname=@nameInput WHERE identifier=@identifier", {
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
        ['@nameInput'] = tostring(nameInput)
    })
end)


AddEventHandler("esx_identity:updatelastname", function(prenomInput)
	MySQL.Async.execute("UPDATE users SET lastname=@prenomInput WHERE identifier=@identifier", {
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
        ['@prenomInput'] = tostring(prenomInput)
    })
end)


AddEventHandler("esx_identity:updateheight", function(tailleInput)
	MySQL.Async.execute("UPDATE users SET height=@tailleInput WHERE identifier=@identifier", {
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
        ['@tailleInput'] = tonumber(tailleInput)
    })
end)

AddEventHandler("esx_identity:updatesexxx", function(sexInput)
	MySQL.Async.execute("UPDATE users SET sex=@sexInput WHERE identifier=@identifier", {
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
        ['@sexInput'] = tostring(sexInput)
    })
end)

AddEventHandler("esx_identity:updatedateofbirth", function(dateInput)
	MySQL.Async.execute("UPDATE users SET dateofbirth=@dateInput WHERE identifier=@identifier", {
        ['@identifier'] = GetPlayerIdentifiers(source)[1],
        ['@dateInput'] = tostring(dateInput)
    })
end)

AddEventHandler("Creator:setPlayerToBucket", function(id)
    SetPlayerRoutingBucket(source, id)
end)

AddEventHandler("Creator:setPlayerToNormalBucket", function()
    SetPlayerRoutingBucket(source, 0)
end)