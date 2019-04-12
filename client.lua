-- Debug Gang

function DrawTxt(text, x, y)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		
    	roundx = tonumber(string.format("%.2f", x))
    	roundy = tonumber(string.format("%.2f", y))
		roundz = tonumber(string.format("%.2f", z))
		
		DrawTxt("~r~X:~s~ "..roundx, 0.32, 0.00)
		DrawTxt("~r~Y:~s~ "..roundy, 0.38, 0.00)
		DrawTxt("~r~Z:~s~ "..roundz, 0.445, 0.00)

		heading = GetEntityHeading(GetPlayerPed(-1))
		roundh = tonumber(string.format("%.2f", heading))
		DrawTxt("~r~H:~s~ "..roundh, 0.50, 0.00)

        local rx,ry,rz = table.unpack(GetEntityRotation(PlayerPedId(), 1))
		DrawTxt("~r~RX:~s~ "..tonumber(string.format("%.2f", rx)), 0.38, 0.03)
		DrawTxt("~r~RY:~s~ "..tonumber(string.format("%.2f", ry)), 0.44, 0.03)
		DrawTxt("~r~RZ:~s~ "..tonumber(string.format("%.2f", rz)), 0.495, 0.03)
	
		speed = GetEntitySpeed(PlayerPedId())
		rounds = tonumber(string.format("%.2f", speed))
		DrawTxt("~r~Player Speed: ~s~"..rounds, 0.40, 0.92)

		health = GetEntityHealth(PlayerPedId())
		DrawTxt("~r~Player Health: ~s~"..health, 0.40, 0.95)

		veheng = GetVehicleEngineHealth(GetVehiclePedIsUsing(PlayerPedId()))
		vehbody = GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId()))
		if IsPedInAnyVehicle(PlayerPedId(), 1) then
			vehenground = tonumber(string.format("%.2f", veheng))
			vehbodround = tonumber(string.format("%.2f", vehbody))

			DrawTxt("~r~Engine Health: ~s~"..vehenground, 0.015, 0.76)

			DrawTxt("~r~Body Health: ~s~"..vehbodround, 0.015, 0.73)

			DrawTxt("~r~Vehicle Fuel: ~s~"..tonumber(string.format("%.2f", GetVehicleFuelLevel(GetVehiclePedIsUsing(PlayerPedId())))), 0.015, 0.70)
		end
    end
end)

local table
local lastvalid
local ready = false

function InitializeAOP(zone)
	local playerPed = GetPlayerPed(-1)
	if (zone == "default") then
		table = config.zones[config.defaultzone]
		lastvalid = table.location
	else
		table = zone
		lastvalid = zone.location
	end
	print("e")
	SetEntityCoords(playerPed, table.location.x, table.location.y, table.location.z, 0, 0, 0, false)
	ready = true
end

Citizen.CreateThread(function()
	while ready do
		local playerPed = GetPlayerPed(-1)
		Citizen.Wait(0)
		local plyCoords = GetEntityCoords(playerPed, false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, table.location.x, table.location.y, table.location.z)
		if dist <= table.radius / 2 then
			if (dist <= (table.radius / 2) - 0.5) then
				lastvalid = plyCoords
			end
		else
			local vehicle
			if (IsPedInAnyVehicle(playerPed, true)) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
			end
			local validnotfound = true
			local index = 0
			if (vehicle) then
				SetEntityCoordsNoOffset(vehicle, lastvalid.x + index, lastvalid.y + index, lastvalid.z, 0, 0, 1)
			else 
				SetEntityCoords(playerPed, lastvalid.x + index, lastvalid.y + index, lastvalid.z, 0, 0, 0, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	InitializeAOP("default")
	local playerPed = GetPlayerPed(-1)
	while ready do
		local plyCoords = GetEntityCoords(playerPed, false)
		Citizen.Wait(0)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, table.location.x, table.location.y, table.location.z)
		print(dist)
		if (dist >= (table.radius / 2) - table.visabilitydistance) then
			DrawMarker(1, table.location.x, table.location.y, table.location.z, 0, 0, 0, 0, 0, 0, table.radius + 0.0, table.radius + 0.0, table.height + 0.0, table.color.r, table.color.g, table.color.b, table.color.a, 0, 0, 0, 0)
		end
	end
end)

RegisterNetEvent("aop:InitializeAOP")
AddEventHandler("aop:InitializeAOP", function(zone)
	InitializeAOP(zone)
end)