TriggerEvent('chat:addSuggestion', '/twt', 'Faire un tweet', {
    { name="Message", help="Quoi de neuf ?" },
})

TriggerEvent('chat:addSuggestion', '/ano', 'Faire un message anonyme', {
    { name="Message", help= "Votre message ?" },
})

TriggerEvent('chat:addSuggestion', '/annonce', 'Faire une annonce (S.Admin)')

TriggerEvent('chat:addSuggestion', '/tpa', "TP quelqu'un a un endroit spécifique", {
    { name="ID", help= "l'id du mec ?"},
    { name="type", help= "Ou le TP ?"},
})

RegisterNetEvent('rAdminCommand:tpa')
AddEventHandler('rAdminCommand:tpa', function(type)
    if type == 'pc' then
        SetEntityCoords(PlayerPedId(), vector3(215.76, -810.12, 30.73))
    elseif type == 'ems' then
        SetEntityCoords(PlayerPedId(), vector3(293.58, -597.83, 43.27))
    elseif type == 'concess' then
        SetEntityCoords(PlayerPedId(), vector3(-54.44, -1105.42, 26.44))
    else
        print("Cet endroit n'existe pas")
    end
end)