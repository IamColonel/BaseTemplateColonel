-- Interaction Zone
local interval = 250
local canInteract = true

-- Index for RageUI List
local index = {masque = 0, sliderPanel = {min = 0, ind = 0, ind2 = 0, ind3 = 0, ind4 = 0, max = 6}}

ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
    end 
end)

RegisterNetEvent('wMask:Save')
AddEventHandler('wMask:Save', function()
    TriggerEvent("skinchanger:getSkin", function(skin)
        TriggerServerEvent('esx_skin:save', skin)
    end)
end)


local removeAllCompo = function()
    TriggerEvent("skinchanger:change", "mask_1 ", 0)
end

local openMask = function()
    FreezeEntityPosition(PlayerPedId(), true)
    local main = RageUI.CreateMenu("Magasin Masque", " ");
    main:SetRectangleBanner(11, 11, 11, 1)
    main.EnableMouse = true

    RageUI.Visible(main, not RageUI.Visible(main)) 
    removeAllCompo()
    
    while main do
        Citizen.Wait(0)
        RageUI.IsVisible(main, function()
            -- Get Information from player ped
            local masque = {} for i = 0, GetNumberOfPedDrawableVariations(PlayerPedId(), 1) - 1, 1 do masque[i] = i end
            RageUI.Separator('Prix du Masque: ~g~'..Mask.Price.."$")

            RageUI.List("Masque", masque, index.masque, nil, {}, true, {
                onListChange = function(Index, Item)
                    index.masque = Index;
                    TriggerEvent("skinchanger:change", "mask_1", index.masque - 1)
                end
            })

            RageUI.SliderPanel(index.sliderPanel.ind, 0, "Couleurs", index.sliderPanel.max, {
                onSliderChange = function(Index)
                    index.sliderPanel.ind = Index
                    TriggerEvent("skinchanger:change", "mask_2", index.sliderPanel.ind)
                end
            }, 2)

            RageUI.Separator()
            RageUI.Separator()

            RageUI.Button("Valider vos choix", nil, {}, true, {
                onSelected = function()
                    TriggerServerEvent('wMask:Buy')
                end
            })
        end)


        if not RageUI.Visible(main) then 
            main = RMenu:DeleteType('main', true)   
            canInteract = true
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
            end)
            index.masque = 0;
            RageUI.CloseAll()
            RenderScriptCams(false, false, 0, 1, 0)
            DestroyCam(cam, false)
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local interval = 250
        for k,v in pairs(Mask.Pos) do
            local playerPos = GetEntityCoords(PlayerPedId())
            local zone = v
            local distance = #(playerPos - zone)
            if distance <= 9 then
                interval = 0
                DrawMarker(22, zone, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 52, 158, 235, 140, 55555, false, true, 2, false, false, false, false)
                if distance <= 1.0 then
                    if canInteract then
                        ESX.ShowHelpNotification('Appuyez sur ~INPUT_CONTEXT~ pour accéder au magasin de ~b~Masque~s~')
                        if IsControlJustPressed(0, 51) then
                            canInteract = false
                            openMask()
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)
