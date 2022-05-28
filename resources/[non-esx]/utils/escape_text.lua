Citizen.CreateThread(function()
    while true do
        AddTextEntry('PM_SCR_MAP', '~b~Carte de Los Santos')
        AddTextEntry('PM_SCR_GAM', '~r~Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', '~g~Logs')
        AddTextEntry('PM_SCR_SET', '~p~Configuration')
        AddTextEntry('PM_SCR_STA', '~b~Statistiques')
        AddTextEntry('PM_SCR_GAL', '~y~Galerie')
        AddTextEntry('PM_SCR_RPL', '~y~Éditeur ∑')
        AddTextEntry('PM_PANE_CFX', '~y~Fataliste RP')
        AddTextEntry('FE_THDR_GTAO', "~b~Base Template ~m~| ~b~discord.gg/ ~m~| ~b~ID : ~w~".. GetPlayerServerId(PlayerId()) .." ~m~| ~b~"..#GetActivePlayers().. "~w~/~b~64 ~w~joueurs ~b~en ligne")
        AddTextEntry('PM_PANE_LEAVE', '~p~Se déconnecter de notre serveur');
        AddTextEntry('PM_PANE_QUIT', '~r~Quitter FiveM');
        Citizen.Wait(5000)
    end
end)


Citizen.CreateThread(function()
    ReplaceHudColour(116, 6)
end)