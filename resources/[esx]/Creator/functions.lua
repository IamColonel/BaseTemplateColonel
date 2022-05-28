RegisterNetEvent('esx:playerLoaded')

whenActive, PlayerLoaded, FirstSpawn, CinemaMode = false, false, true, false

AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

loadIplCreator = function(load)
    CreateThread(function()
        while load do
            Wait(0)
            RequestIpl('ex_dt1_11_office_01a')
            break
        end
    end)
end

Notification = function(msg)
    SetNotificationTextEntry('STRING') 
    AddTextComponentSubstringPlayerName(msg) 
    DrawNotification(false, true) 
end

HelpNotification = function(text, sound, time)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	if string.len(text) > 99 and AddLongString then AddLongString(text) end
	DisplayHelpTextFromStringLabel(0, 0, sound, time)
end

-- Advancednotif(title, subject, msg, icon, iconType)
Advancednotif = function(title, subject, msg, icon, iconType)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    SetNotificationMessage(icon, icon, false, iconType, title, subject)
    DrawNotification(false, false)
end

Character = {}
local pedModel = 'mp_m_freemode_01'
changeGender = function(sex)
	if sex == 1 then
		Character['sex'] = 0
		pedModel = 'mp_m_freemode_01'
		changeModel(pedModel)
	else
		Character['sex'] = 1
		pedModel = 'mp_f_freemode_01'
		changeModel(pedModel)
	end
end

changeModel = function(skin)
    if IsModelInCdimage(GetHashKey(skin)) and IsModelValid(GetHashKey(skin)) then
        RequestModel(GetHashKey(skin))
        while not HasModelLoaded(GetHashKey(skin)) do
            Wait(0)
        end
        SetPlayerModel(PlayerId(), GetHashKey(skin))
        SetPedDefaultComponentVariation(PlayerPedId())

        if skin == 'mp_m_freemode_01' then
            SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 2) -- arms
            SetPedComponentVariation(PlayerPedId(), 11, 15, 0, 2) -- torso
            SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 2) -- tshirt
            SetPedComponentVariation(PlayerPedId(), 4, 61, 4, 2) -- pants
            SetPedComponentVariation(PlayerPedId(), 6, 34, 0, 2) -- shoes

            Character['arms'] = 15
            Character['torso_1'] = 15
            Character['tshirt_1'] = 15
            Character['pants_1'] = 61
            Character['pants_2'] = 4
            Character['shoes_1'] = 34
            Character['glasses_1'] = 0
            TriggerEvent("skinchanger:change", "sex", 0)
        elseif skin == 'mp_f_freemode_01' then
            SetPedComponentVariation(PlayerPedId(), 3, 15, 0, 2) -- arms
            SetPedComponentVariation(PlayerPedId(), 11, 5, 0, 2) -- torso
            SetPedComponentVariation(PlayerPedId(), 8, 15, 0, 2) -- tshirt
            SetPedComponentVariation(PlayerPedId(), 4, 57, 0, 2) -- pants
            SetPedComponentVariation(PlayerPedId(), 6, 35, 0, 2) -- shoes

            Character['arms'] = 15
            Character['torso_1'] = 5
            Character['tshirt_1'] = 15
            Character['pants_1'] = 57
            Character['pants_2'] = 0
            Character['shoes_1'] = 35
            Character['glasses_1'] = -1
            TriggerEvent("skinchanger:change", "sex", 1)
        end
        SetModelAsNoLongerNeeded(GetHashKey(skin))
    end
end

function PlayAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 1, 1, false, false, false)
    RemoveAnimDict(animDict)
end

local function LeMessage(messages) 
	SetTextFont(0) 
	SetTextProportional(0) 
	SetTextScale(0.40, 0.40) 
	SetTextDropShadow(0, 0, 0, 0,255) 
	SetTextEdge(1, 0, 0, 0, 255) 
	SetTextEntry("STRING") 
	AddTextComponentString(messages)
	DrawText(0.41, 0.91) 
end

setAnimation = function(coords)
    CinemaMode = true
    TaskGoStraightToCoord(PlayerPedId(), coords, 1.0, 8000, 265.25466, 5)
    CinemaMode = false
end

setAnimation2 = function(coords)
    CinemaMode = true
    TaskGoStraightToCoord(PlayerPedId(), coords, 1.0, 8000, 69.03946685791, 5)
    CinemaMode = false
end

local msg = false
FirstSpawnFunction = function()
    loadIplCreator(true)
    DoScreenFadeOut(1500)
    Wait(1500)
    DisplayRadar(false)
    TriggerEvent(Config.HideHudEventName, false) 
    TriggerEvent(Config.HideStatusEventName, false)
    changeGender(1)
    TriggerServerEvent("Creator:setPlayerToBucket", GetPlayerServerId(PlayerId()))
    whenActive = true
    SetEntityCoords(PlayerPedId(), vector3(366.93, 4826.15, -59.0))
    SetEntityHeading(PlayerPedId(), 217.12)
    PlayAnim("timetable@ron@ig_5_p3", "ig_5_p3_base", 50000)
    setCameraCreator(1)
    Wait(1000)
    DoScreenFadeIn(1500)
    msg = true
    FreezeEntityPosition(PlayerPedId(), true)
    CreateThread(function()
		while msg do
				Wait(0)
                LeMessage("Appuyez sur [~b~E~s~] pour vous enregistrer")
			if IsControlPressed(1, 38) then
                msg = false
                OpenIdentityMenu()
            end
        end
    end)
end

RegisterCommand("register", function() FirstSpawnFunction() end)

CreationPersoFunction = function()
    ClearPedTasks(PlayerPedId())
    DoScreenFadeOut(1500)
    Wait(1500)
    SetEntityCoords(PlayerPedId(), vector3(370.2033, 4822.2875, -59.991))
    Wait(1000)
    DoScreenFadeIn(1500)
    openCreatorMenu()
    whenActive = false
end
choixpoitionfunction = function()
    whenActive = true
TriggerEvent('skinchanger:getSkin', function(skin)
      TriggerServerEvent('esx_skin:save', skin)
    end)
    openChoiceMenuSpawning()
end


local RegisterPedTables = {
    [0] = "MP_Plane_Passenger_1",
    [1] = "MP_Plane_Passenger_2",
    [2] = "MP_Plane_Passenger_3",
    [3] = "MP_Plane_Passenger_4",
    [4] = "MP_Plane_Passenger_5",
    [5] = "MP_Plane_Passenger_6",
    [6] = "MP_Plane_Passenger_7",
    [7] = "MP_Plane_Passenger_8",
    [8] = "MP_Plane_Passenger_9",
    [9] = "MP_Plane_Passenger_10"
}

setPedProperty = function(ped, args)
    if args == 0 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    elseif args == 1 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    elseif args == 2 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    elseif args == 3 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    elseif args == 4 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    elseif args == 5 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    elseif args == 6 then
        SetEntityVisible(ped, false, 0)
        SetEntityVisibleInCutscene(ped, false, 0)
    end
end

setCameraCreator = function(camType)
    if camType == 1 then
        cam1 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam1, true)
        PointCamAtEntity(cam1, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam1, 371.19, 4820.77, -59.0, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam1, 50.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 2 then
        cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam2, true)
        PointCamAtEntity(cam2, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam2,-65.1357, -804.7418, 244.4058, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam2, 50.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 3 then
        cam3 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam3, true)
        PointCamAtEntity(cam3, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam3, -58.78357, -809.7481, 245.388, 2.0, 0.0, 72.709175109863, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam3, 70.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 4 then
        cam4 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam4, true)
        PointCamAtEntity(cam4, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam4, -81.9896, -803.7953, 244.3903, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam4, 50.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 5 then
        cam5 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam5, true)
        PointCamAtEntity(cam5, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam5, -79.97163, -811.4866, 243.386, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam5, 70.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 6 then
        cam6 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam6, true)
        PointCamAtEntity(cam6, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam6, -73.73689, -818.9836, 244.386, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam6, 70.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 7 then
        cam7 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam7, true)
        PointCamAtEntity(cam7, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam7,-65.1357, -804.7418, 244.4058, 2.0, 0.0, 129.0322265625, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam7, 50.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    elseif camType == 8 then
        cam8 = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(cam8, true)
        PointCamAtEntity(cam8, PlayerPedId(), 0, 0, 0, 1)
        SetCamParams(cam8, -58.78357, -809.7481, 245.388, 2.0, 0.0, 72.709175109863, 70.2442, 0, 1, 1, 2)
        SetCamFov(cam8, 70.0)
        RenderScriptCams(1, 0, 0, 1, 1)
    end
end

destroyCameraCreator = function(destroyCam)
    if destroyCam == 1 then
        DestroyCam(cam1, false)
        RenderScriptCams(false, true, 1500, false, false)
    elseif destroyCam == 2 then
        DestroyCam(cam2, false)
        RenderScriptCams(false, true, 800, false, false)
    elseif destroyCam == 3 then
        DestroyCam(cam3, false)
        RenderScriptCams(false, true, 800, false, false)
    elseif destroyCam == 4 then
        DestroyCam(cam4, false)
        RenderScriptCams(false, true, 800, false, false)
    elseif destroyCam == 5 then
        DestroyCam(cam5, false)
        RenderScriptCams(false, true, 800, false, false)
    elseif destroyCam == 6 then
        DestroyCam(cam6, false)
        RenderScriptCams(false, true, 800, false, false)
    elseif destroyCam == 7 then
        DestroyCam(cam2, false)
        RenderScriptCams(false, true, 800, false, false)
    elseif destroyCam == 8 then
        DestroyCam(cam3, false)
        RenderScriptCams(false, true, 800, false, false)
    end
end

CreateThread(function()
    while true do
        Wait(1)
		if CinemaMode then
			DrawRect(0.471, 0.0485, 1.065, 0.13, 0, 0, 0, 255)
			DrawRect(0.503, 0.935, 1.042, 0.13, 0, 0, 0, 255)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()
		else
			Wait(1000)
		end
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if whenActive then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            Wait(100)
        end
    end
end)



AddEventHandler('playerSpawned', function()
	CreateThread(function()
		while not PlayerLoaded do Wait(10) end

		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
                    loadIplCreator(true)
                    FirstSpawnFunction()
                else
                    TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)
			FirstSpawn = false
		end
	end)
end)	