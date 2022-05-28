local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- CalmAl

SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_FAMILY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MARABUNTE"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_SALVA"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_1"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_2"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_9"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("GANG_10"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("A_C_ROTTWEILER"), GetHashKey('PLAYER'))

------- Pause Menu texte 

-- function SetData()
-- 	players = {}
-- 	for _, player in ipairs(GetActivePlayers()) do
-- 		local ped = GetPlayerPed(player)
-- 		table.insert( players, player )
-- end

	
-- 	local name = GetPlayerName(PlayerId())
-- 	local id = GetPlayerServerId(PlayerId())
-- 	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), 'FE_THDR_GTAO', '~r~BaseTemplateColonel~s~ | ID : ~p~'.. id ..'~w~ | Joueurs connectés : ~p~' .. #players .."~w~/64 " )
-- end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(100)
-- 		SetData()
-- 	end
-- end)

-- Citizen.CreateThread(function()
--     AddTextEntry("PM_PANE_LEAVE", "~r~Se déconnecter ~w~de~r~ BaseTemplateColonel")
-- end)

-- Citizen.CreateThread(function()
--     AddTextEntry("PM_PANE_QUIT", "Quitter ~y~FiveM 🐌")
-- end)

-- Realistic Traffic 

-- local vehRoadDensity = 0.65
-- local vehParkedDensity = 0.8

-- Citizen.CreateThread(function()
-- 	while true do
-- 	    Citizen.Wait(0)
        
-- 	    SetVehicleDensityMultiplierThisFrame(vehRoadDensity)
-- 	    SetParkedVehicleDensityMultiplierThisFrame(vehParkedDensity)
-- 	end
-- end)

-- PvP

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

-- PiggyBack

-- local piggyBackInProgress = false

-- RegisterCommand("porter",function(source, args)
-- 	if not piggyBackInProgress then
-- 		piggyBackInProgress = true
-- 		local player = PlayerPedId()	
-- 		lib = 'anim@arena@celeb@flat@paired@no_props@'
-- 		anim1 = 'piggyback_c_player_a'
-- 		anim2 = 'piggyback_c_player_b'
-- 		distans = -0.07
-- 		distans2 = 0.0
-- 		height = 0.45
-- 		spin = 0.0		
-- 		length = 100000
-- 		controlFlagMe = 49
-- 		controlFlagTarget = 33
-- 		animFlagTarget = 1
-- 		local closestPlayer = GetClosestPlayer(3)
-- 		target = GetPlayerServerId(closestPlayer)
-- 		if closestPlayer ~= nil then
-- 			print("triggering cmg2_animations:sync")
-- 			TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
-- 		else
-- 			print("[CMG Anim] No player nearby")
-- 		end
-- 	else
-- 		piggyBackInProgress = false
-- 		ClearPedSecondaryTask(GetPlayerPed(-1))
-- 		DetachEntity(GetPlayerPed(-1), true, false)
-- 		local closestPlayer = GetClosestPlayer(3)
-- 		target = GetPlayerServerId(closestPlayer)
-- 		TriggerServerEvent("cmg2_animations:stop",target)
-- 	end
-- end,false)

-- RegisterNetEvent('cmg2_animations:syncTarget')
-- AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
-- 	local playerPed = GetPlayerPed(-1)
-- 	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
-- 	piggyBackInProgress = true
-- 	print("triggered cmg2_animations:syncTarget")
-- 	RequestAnimDict(animationLib)

-- 	while not HasAnimDictLoaded(animationLib) do
-- 		Citizen.Wait(10)
-- 	end
-- 	if spin == nil then spin = 180.0 end
-- 	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
-- 	if controlFlag == nil then controlFlag = 0 end
-- 	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
-- end)

-- RegisterNetEvent('cmg2_animations:syncMe')
-- AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
-- 	local playerPed = GetPlayerPed(-1)
-- 	print("triggered cmg2_animations:syncMe")
-- 	RequestAnimDict(animationLib)

-- 	while not HasAnimDictLoaded(animationLib) do
-- 		Citizen.Wait(10)
-- 	end
-- 	Wait(500)
-- 	if controlFlag == nil then controlFlag = 0 end
-- 	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

-- 	Citizen.Wait(length)
-- end)

-- RegisterNetEvent('cmg2_animations:cl_stop')
-- AddEventHandler('cmg2_animations:cl_stop', function()
-- 	piggyBackInProgress = false
-- 	ClearPedSecondaryTask(GetPlayerPed(-1))
-- 	DetachEntity(GetPlayerPed(-1), true, false)
-- end)

-- function GetPlayers()
--     local players = {}

--     for i = 0, 255 do
--         if NetworkIsPlayerActive(i) then
--             table.insert(players, i)
--         end
--     end

--     return players
-- end

-- function GetClosestPlayer(radius)
--     local players = GetPlayers()
--     local closestDistance = -1
--     local closestPlayer = -1
--     local ply = GetPlayerPed(-1)
--     local plyCoords = GetEntityCoords(ply, 0)

--     for index,value in ipairs(players) do
--         local target = GetPlayerPed(value)
--         if(target ~= ply) then
--             local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
--             local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
--             if(closestDistance == -1 or closestDistance > distance) then
--                 closestPlayer = value
--                 closestDistance = distance
--             end
--         end
--     end
-- 	print("closest player is dist: " .. tostring(closestDistance))
-- 	if closestDistance <= radius then
-- 		return closestPlayer
-- 	else
-- 		return nil
-- 	end
-- end

-- esx_announce

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('announce')
AddEventHandler('announce', function(title, msg, sec)
	ESX.Scaleform.ShowFreemodeMessage(title, msg, sec)
end)

-- no reticle

Citizen.CreateThread(function()
    local isSniper = false
    while true do
        Citizen.Wait(4)

        local ped = GetPlayerPed(-1)
        local currentWeaponHash = GetSelectedPedWeapon(ped)

        if currentWeaponHash == 100416529 then
            isSniper = true
        elseif currentWeaponHash == 205991906 then
            isSniper = true
        elseif currentWeaponHash == -952879014 then
            isSniper = true
        elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
            isSniper = true
        else
            isSniper = false
        end

        if not isSniper then
            HideHudComponentThisFrame(14)
        end
    end
end)

-------- DROP ARMES ----------

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
	  RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
	  RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
	  RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
	end
  end)
  
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(0)
		  DisablePlayerVehicleRewards(PlayerId())
	  end
  end)

--------- Enlever les flics -------------

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
	local playerPed = GetPlayerPed(-1)
	local playerLocalisation = GetEntityCoords(playerPed)
	ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
	end
	end)

-- Discord 

-- local id2 = GetPlayerServerId(PlayerId())

-- -- ID

-- RegisterCommand("id",function()
-- 	id()
-- end)

-- function id()
-- 	ESX.ShowNotification("~b~Votre ID : ~r~".. id2 .."") 
-- end




-- Coup de cross 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
	local ped = PlayerPedId()
        if IsPedArmed(ped, 6) then
	       DisableControlAction(1, 140, true)
       	   DisableControlAction(1, 141, true)
           DisableControlAction(1, 142, true)
        end
    end
end)

-- dispatch LSPD

Citizen.CreateThread(function()
	while true do
		Wait(500)
		for i = 1, 12 do
			EnableDispatchService(i, false)
		end
		SetPlayerWantedLevel(PlayerId(), 0, false)
		SetPlayerWantedLevelNow(PlayerId(), false)
		SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end
end)

-- pos

RegisterCommand("pos", function()
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local plyHeading = GetEntityHeading(plyPed)
    ESX.ShowNotification("Les Coordonnées ont été envoyées dans le F8")
    print("[Position Obtenue] x: " .. plyPos.x .. " | y: " .. plyPos.y .. " | z: " .. plyPos.z .. "| Heading: " .. plyHeading)
end, false)

--
