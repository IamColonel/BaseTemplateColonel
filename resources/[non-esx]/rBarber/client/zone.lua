-- Interaction Zone
local interval = 250
local canInteract = true

-- Index for RageUI List
local index = {cheveux = 0, barbe = 0, sourcil = 0, cheveuxcolor = 0, barbecolor = 0}

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
    end 
end)

RegisterNetEvent('wBarber:Save')
AddEventHandler('wBarber:Save', function()
    TriggerEvent("skinchanger:getSkin", function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)


local removeAllCompo = function()
    TriggerEvent("skinchanger:change", "hair_1", 0)
    TriggerEvent("skinchanger:change", "beard_1", 0)
    TriggerEvent("skinchanger:change", "eyebrows_1", 0)
end

local openBarber = function()
    local main = RageUI.CreateMenu("BarberShop", " ");    
    local sub = RageUI.CreateSubMenu(main, "Barber Shop", " ")
    main:SetRectangleBanner(11, 11, 11, 1)
    sub:SetRectangleBanner(11, 11, 11, 1)

    RageUI.Visible(main, not RageUI.Visible(main)) 
    removeAllCompo()
    
    while main do
        Citizen.Wait(0)
	-- Get Information from player ped
        local cheveux = {} for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 2) - 1, 1 do cheveux[i] = i end
        local barbe = {} for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 1) - 1, 1 do barbe[i] = i end
        local sourcil = {} for i = 0, GetNumHeadOverlayValues(2) -1, 1 do sourcil[i] = i end
        local cheveuxcolor = {} for i = 0, GetNumHairColors(2) -1, 1 do cheveuxcolor[i] = i end
        local barbecolor = {} for i = 0, GetNumHairColors(1) -1, 1 do barbecolor[i] = i end
        RageUI.IsVisible(main, function()
            RageUI.Button('Modifier votre personnage', nil, {}, true, {}, sub);
        end)

        RageUI.IsVisible(sub, function()

            RageUI.Separator('Prix du Barber: ~g~'..Barber.Price.."$")

            RageUI.List("Cheveux", cheveux, index.cheveux, nil, {}, true, {
                onListChange = function(Index, Item)
                    index.cheveux = Index;
                    TriggerEvent("skinchanger:change", "hair_1", index.cheveux - 1)
                end
            })

            RageUI.List("Cheveux (Couleur)", cheveuxcolor, index.cheveuxcolor, nil, {}, true, {
                onListChange = function(Index, Item)
                    index.cheveuxcolor = Index;
                    TriggerEvent("skinchanger:change", "hair_color_1", index.cheveuxcolor - 1)
                end
            })

            RageUI.List("Barbe", barbe, index.barbe, nil, {}, true, {
                onListChange = function(Index, Item)
                    index.barbe = Index;
                    TriggerEvent("skinchanger:change", "beard_1", index.barbe - 1)
				    TriggerEvent("skinchanger:change", "beard_2", 100)
                end
            })

            RageUI.List("Barbe (Couleur)", barbecolor, index.barbecolor, nil, {}, true, {
                onListChange = function(Index, Item)
                    index.barbecolor = Index;
                    TriggerEvent("skinchanger:change", "beard_3", index.barbecolor - 1)
                end
            })

            RageUI.List("Sourcil", sourcil, index.sourcil, nil, {}, true, {
                onListChange = function(Index, Item)
                    index.sourcil = Index;
                    TriggerEvent("skinchanger:change", "eyebrows_1", index.sourcil - 1)
					TriggerEvent("skinchanger:change", "eyebrows_2", 100)
                end
            })

            RageUI.Button("Valider vos choix", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('wBarber:Buy')
                end
            })

        end)

        if not RageUI.Visible(main) and not RageUI.Visible(sub) then 
            main = RMenu:DeleteType('main', true)   
            sub = RMenu:DeleteType('sub', true)
            canInteract = true
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            RageUI.CloseAll()
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local interval = 250
        for k,v in pairs(Barber.Pos) do
            local playerPos = GetEntityCoords(PlayerPedId())
            local zone = v
            local distance = #(playerPos - zone)
            if distance <= 9 then
                interval = 0
                DrawMarker(22, zone, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 52, 158, 235, 140, 55555, false, true, 2, false, false, false, false)
                if distance <= 1.0 then
                    if canInteract then
                        ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Barber~s~')
                        if IsControlJustPressed(0, 51) then
                            canInteract = false
                            openBarber()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)
