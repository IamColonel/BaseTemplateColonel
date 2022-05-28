Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId() then
				if GetIsTaskActive(PlayerPedId(), 165) then
					SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
				end
			end
		end
	end
end)

-- MONTER A L'ARRIERE DU VEHICULE

local doors = {
	{"seat_dside_f", -1},
	{"seat_pside_f", 0},
	{"seat_dside_r", 1},
	{"seat_pside_r", 2}
}

function VehicleInFront(ped)
    local pos = GetEntityCoords(ped)
    local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, ped, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)

    return result
end

Citizen.CreateThread(function()
	while true do
    	Citizen.Wait(0)

		local ped = PlayerPedId()

   		if IsControlJustReleased(0, 23) and not running and GetVehiclePedIsIn(ped, false) == 0 then
      		local vehicle = VehicleInFront(ped)

      		running = true

      		if vehicle ~= nil then
				local plyCoords = GetEntityCoords(ped, false)
        		local doorDistances = {}

        		for k, door in pairs(doors) do
          			local doorBone = GetEntityBoneIndexByName(vehicle, door[1])
          			local doorPos = GetWorldPositionOfEntityBone(vehicle, doorBone)
          			local distance = #(plyCoords - doorPos)

          			table.insert(doorDistances, distance)
        		end

        		local key, min = 1, doorDistances[1]

        		for k, v in ipairs(doorDistances) do
          			if doorDistances[k] < min then
           				key, min = k, v
          			end
        		end

        		TaskEnterVehicle(ped, vehicle, 0.0, doors[key][2], 1.5, 1, 0)
     		end

      		running = false
    	end
  	end
end)

-- KEYBIND CHANGEMENT PLACE VEHICLE
Citizen.CreateThread(function()
    while true do
		local sleep = 750
        local plyPed = PlayerPedId()
        if IsPedSittingInAnyVehicle(plyPed) then
			sleep = 1
            local plyVehicle = GetVehiclePedIsIn(plyPed, false)
			local carSpeed = GetEntitySpeed(plyVehicle) * 3.6

			if IsControlJustReleased(0, 157) then -- conducteur
				SetPedIntoVehicle(plyPed, plyVehicle, -1)
				Citizen.Wait(10)
			end

			if IsControlJustReleased(0, 158) then -- avant droit
				if not (IsPedOnAnyBike(plyPed) and carSpeed > 30.0) then
					SetPedIntoVehicle(plyPed, plyVehicle, 0)
					Citizen.Wait(10)
				end
			end

			if IsControlJustReleased(0, 160) then -- arriere gauche
				SetPedIntoVehicle(plyPed, plyVehicle, 1)
				Citizen.Wait(10)
			end

			if IsControlJustReleased(0, 164) then -- arriere gauche
				SetPedIntoVehicle(plyPed, plyVehicle, 2)
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(sleep)
	end
end)



Citizen.CreateThread(function()
    -- Other stuff normally here, stripped for the sake of only scenario stuff
    local SCENARIO_TYPES = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL", -- Zancudo Small Planes
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", -- Zancudo Big Planes
    }
    local SCENARIO_GROUPS = {
        2017590552, -- LSIA planes
        2141866469, -- Sandy Shores planes
        1409640232, -- Grapeseed planes
        "ng_planes", -- Far up in the skies jets
    }
    local SUPPRESSED_MODELS = {
        "SHAMAL", -- They spawn on LSIA and try to take off
        "LUXOR", -- They spawn on LSIA and try to take off
        "LUXOR2", -- They spawn on LSIA and try to take off
        "JET", -- They spawn on LSIA and try to take off and land, remove this if you still want em in the skies
        "LAZER", -- They spawn on Zancudo and try to take off
        "TITAN", -- They spawn on Zancudo and try to take off
        "BARRACKS", -- Regularily driving around the Zancudo airport surface
        "BARRACKS2", -- Regularily driving around the Zancudo airport surface
        "CRUSADER", -- Regularily driving around the Zancudo airport surface
        "RHINO", -- Regularily driving around the Zancudo airport surface
        "AIRTUG", -- Regularily spawns on the LSIA airport surface
        "RIPLEY", -- Regularily spawns on the LSIA airport surface
    }

    while true do
        for _, sctyp in next, SCENARIO_TYPES do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, SCENARIO_GROUPS do
            SetScenarioGroupEnabled(scgrp, false)
        end
        for _, model in next, SUPPRESSED_MODELS do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end
        Wait(10000)
    end
end)