ESX = nil

local CarteSimTable = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local numero = nil
local id = nil

function MenuCarteSim()
    local MCarteSim = RageUI.CreateMenu("Carte SIM", "Téléphone")
    local MCarteSimSub = RageUI.CreateSubMenu(MCarteSim, "Carte SIM", "Téléphone")
    MCarteSim:SetRectangleBanner(11, 11, 11, 1)
    MCarteSimSub:SetRectangleBanner(11, 11, 11, 1)
        RageUI.Visible(MCarteSim, not RageUI.Visible(MCarteSim))
            while MCarteSim do
            Citizen.Wait(0)
            RageUI.IsVisible(MCarteSim, true, true, true, function()
                if #CarteSimTable >= 1 then
                for k,v in ipairs(CarteSimTable) do
                    RageUI.ButtonWithStyle("~r~→~s~ Numéro: "..v.number.." || Nom: "..v.label, nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            numero = v.number
                            id = v.id
                        end
                    end, MCarteSimSub)
                end
                else
                    RageUI.Separator("")
                    RageUI.Separator("Aucune Carte SIM")
                    RageUI.Separator("")
                end
                end, function()
                end)

                RageUI.IsVisible(MCarteSimSub, true, true, true, function()

                    RageUI.Separator("~b~Action disponible pour le numéro : "..numero)

                    RageUI.ButtonWithStyle("Utiliser", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            ESX.TriggerServerCallback('rCarteSim:getItemAmount', function(qtty)
                                if qtty >= 0 then
                                    TriggerServerEvent("rCarteSim:SetNumber", numero)
                                    else
                                        ESX.ShowNotification("~r~Pas de téléphone ! ")
                                    end
                            end, Config.nomduteldb)
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Renommer", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local NewName = CarteSimKeyboardInput('veuillez saisir le nouveau nom ?', '', 40)
                            if NewName then
                                TriggerServerEvent('rCarteSim:RenameSim', id, NewName, numero)
                                RageUI.CloseAll()
                            else
                                ESX.ShowNotification("Veuillez saisir un nom valable !")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Donner",nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local closestPed = GetPlayerPed(closestPlayer)
              
                            if IsPedSittingInAnyVehicle(closestPed) then
                                ESX.ShowNotification('~r~Vous ne pouvez pas donner quelque chose à quelqu\'un dans un véhicule')
                                return
                            end
              
                            if closestPlayer ~= -1 and closestDistance < 3.0 then
                                PlayAnim("mp_common", "givetake1_a")
                                TriggerServerEvent('rCarteSim:GiveNumber', GetPlayerServerId(closestPlayer), numero)
                                RageUI.CloseAll()
                            else
                                ESX.ShowNotification("~r~Personne à proximité")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Jeter", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            TriggerServerEvent('rCarteSim:Supprimer', numero)
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(MCarteSim) and not RageUI.Visible(MCarteSimSub) then
            MCarteSim = RMenu:DeleteType("MCarteSim", true)
        end
    end
end

function PlayAnim(lib, anim)
    if IsPlayerDead(PlayerId()) then
        return
    end
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        return
    end
    loadAnimDict(lib)
    TaskPlayAnim(GetPlayerPed(-1), lib, anim, 4.0, -1, -1, 50, 0, false, false, false)
    Citizen.Wait(2500)
    ClearPedTasks(GetPlayerPed(-1))
end


Keys.Register('F3', 'Carte-SIM', 'Ouvrir le menu SIM', function()
    ESX.TriggerServerCallback("rCarteSim:Getlescartesim", function(result2)
        CarteSimTable = result2
        MenuCarteSim()
    end)
end)

function CarteSimKeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end