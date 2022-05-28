ESX = nil

local currentTattoos = {}
local cam = -1
local inMenu = false
local TattoosSelected = {}

Citizen.CreateThread(function()
	addBlips()
   	 TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   	 while ESX == nil do Citizen.Wait(0) end
        
	while true do
		Citizen.Wait(0)
		drawMarkers()
		if(isNearTattoosShop()) then
			RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour se faire tatouer", time_display = 1 })
                if IsControlJustPressed(1,51) then
				inMenu = not inMenu
				ESX.UI.Menu.CloseAll()
				if(inMenu) then
					FreezeEntityPosition(GetPlayerPed(-1), true)
					MenuTattoosShops()
				else
					FreezeEntityPosition(GetPlayerPed(-1), false)
					setPedSkin()
				end
			end
		end


		if(inMenu) then
			if(IsControlJustPressed(1, 177)) then
				ESX.UI.Menu.CloseAll()
				FreezeEntityPosition(GetPlayerPed(-1), false)
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkin()
				inMenu = false
			end
		elseif(DoesCamExist(cam)) then
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false)
		end
	end
end)




function MenuTattoosShops()
    local MenuP = RageUI.CreateMenu('Tattoos', 'Fataliste')
    local MenuS = RageUI.CreateSubMenu(MenuP, 'Tattoos', 'Fataliste')
	MenuP:SetRectangleBanner(11, 11, 11, 1)
	MenuS:SetRectangleBanner(11, 11, 11, 1)
	
    RageUI.Visible(MenuP, not RageUI.Visible(MenuP))

    if(DoesCamExist(cam)) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

    while MenuP do
        Citizen.Wait(0)

        RageUI.IsVisible(MenuP, true, true, true, function()
        for _,v in pairs(tattoosCategories) do
            RageUI.ButtonWithStyle(v.name,nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    TattoosSelected = v
                end
            end, MenuS)
        end
        end)

        RageUI.IsVisible(MenuS, true, true, true, function()

            for k,v in pairs(tattoosList[TattoosSelected.value]) do
                RageUI.ButtonWithStyle("Tattoo n°"..k,nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                    if Active then
                        drawTattoo(k, TattoosSelected.value)
                    end
                    if Selected then
                        TriggerServerEvent("tattoos:save", currentTattoos, v.price, {collection = TattoosSelected.value, texture = k})
                        RageUI.CloseAll()
                        RenderScriptCams(false, false, 0, 1, 0)
                        DestroyCam(cam, false)
                        setPedSkin()
                    end
                end)
            end
            end)

        if not RageUI.Visible(MenuP) and not RageUI.Visible(MenuS) then
            MenuP = RMenu:DeleteType("MenuP", true)
        end
    end
end

function addBlips()
	for _,k in pairs(tattoosShops) do
		local blip = AddBlipForCoord(k.x, k.y, k.z)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipScale(blip, 0.65)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Salon de tatouage")
		EndTextCommandSetBlipName(blip)
	end
end

function drawMarkers()
	for _,k in pairs(tattoosShops) do
		DrawMarker(27,k.x,k.y,k.z-0.9,0,0,0,0,0,0,3.001,3.0001,0.5001,0,155,255,200,0,0,0,0)
	end
end

function isNearTattoosShop()
	for _,k in pairs(tattoosShops) do
		local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), k.x,k.y,k.z, true)

		if(distance < 3) then
			return true
		end
	end

	return false
end



function setPedSkin()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil

        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end

        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
    end)

    Citizen.Wait(1000)

    for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
end




function drawTattoo(current, collection)


	SetEntityHeading(GetPlayerPed(-1), 297.7296)

	ClearPedDecorations(GetPlayerPed(-1))
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end

	if(GetEntityModel(GetPlayerPed(-1)) == -1667301416) then  -- GIRL SKIN
		SetPedComponentVariation(GetPlayerPed(-1), 8, 34,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 101,1, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 16,0, 2)
	else 													  -- BOY SKIN
		SetPedComponentVariation(GetPlayerPed(-1), 8, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 3, 15,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 11, 91,0, 2)
		SetPedComponentVariation(GetPlayerPed(-1), 4, 14,0, 2)
	end



	ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(collection), GetHashKey(tattoosList[collection][current].nameHash))

	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam,  true)
		RenderScriptCams(true,  false,  0,  true,  true)

		SetCamCoord(cam, GetEntityCoords(GetPlayerPed(-1)))
	end

	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

	SetCamCoord(cam, x+tattoosList[collection][current].addedX, y+tattoosList[collection][current].addedY, z+tattoosList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, tattoosList[collection][current].rotZ)
end




function cleanPlayer()
	ClearPedDecorations(GetPlayerPed(-1))
	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
end


function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end






RegisterNetEvent("tattoos:getPlayerTattoos")
AddEventHandler("tattoos:getPlayerTattoos", function(playerTattoosList)
	for _,k in pairs(playerTattoosList) do
		ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
	end
	currentTattoos = playerTattoosList
end)



local firstLoad = false
AddEventHandler("skinchanger:loadSkin", function(skin)
	if(not firstLoad) then
		Citizen.CreateThread(function()

			while not (GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") or GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) do
				Citizen.Wait(10)
			end
			Citizen.Wait(750)
			TriggerServerEvent("tattoos:GetPlayerTattoos_s")
		end)
		firstLoad = true
	else
		Citizen.Wait(750)
		for _,k in pairs(currentTattoos) do
			ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(k.collection), GetHashKey(tattoosList[k.collection][k.texture].nameHash))
		end
	end
end)


RegisterNetEvent("tattoo:buySuccess")
AddEventHandler("tattoo:buySuccess", function(value)
	table.insert(currentTattoos, value)
end)