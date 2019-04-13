local table
local lastvalid
local ready = false
local peacetime = 0
local priority = false

Citizen.CreateThread(function()
	while true do
		if (ready and table.name ~= nil) then
			DrawTxt("~p~AOP~w~: ".. table.name .. "", 4, 1.60, 0.50, 255)
		else
			DrawTxt("~p~AOP~w~: Statewide", 4, 1.60, 0.50, 255)
		end
		DrawTxt("~p~Peacetime~w~: ".. (peacetime ~= 0 and "~g~"..peacetime.."~w~ minutes left" or "~r~Disabled") .. ".	~p~Priority~w~: ".. (priority and "~g~Enabled" or "~r~Disabled") .. ".", 4, 1.50, 0.50, 255)
		Citizen.Wait(0)
	end
end)

-- Debug Gang

function DrawTxt(text, x, y, scale, opacity)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, opacity)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(config.aopdisplay.x / x, config.aopdisplay.y / y)
end

function InitializeAOP(zone)
	local playerPed = GetPlayerPed(-1)
	table = zone
	lastvalid = zone.location
	if (IsPedInAnyVehicle(playerPed, true)) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
		SetEntityAsMissionEntity(vehicle, false, false)
		DeleteEntity(vehicle)
	end
	SetEntityCoords(playerPed, table.location.x, table.location.y, table.location.z, 0, 0, 0, false)
	ready = true
end

Citizen.CreateThread(function()
	while true do
		if (ready) then
			local playerPed = GetPlayerPed(-1)
			local plyCoords = GetEntityCoords(playerPed, false)
			local x = (plyCoords.x - table.location.x)^2 
			local y = (plyCoords.y - table.location.y)^2 
			local z = (plyCoords.z - table.location.z)^2
			local b = x + y + z
			local location = vector3(table.location.x, table.location.y, table.location.z)
			if #(plyCoords - location) < (table.radius) - (table.radius / 150) then
				if #(plyCoords - location) < (table.radius) - (table.radius / 150) - 1.5 then
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
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if ready then
			local playerPed = GetPlayerPed(-1)
			local plyCoords = GetEntityCoords(playerPed, false)
			local location = vector3(table.location.x, table.location.y, table.location.z)
			if (#(plyCoords - location) > (table.radius) - (table.radius / 150) - table.visabilitydistance) then
				DrawMarker(28, table.location.x, table.location.y, table.location.z, 0, 0, 0, 0, 0, 0, table.radius + 0.0, table.radius + 0.0, table.radius + 0.0, table.color.r, table.color.g, table.color.b, table.color.a, 0, 0, 0, 0)
			end
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	TriggerServerEvent("aop:UpdateClientAOP")
	return
end)

RegisterNetEvent("aop:InitializeAOP")
AddEventHandler("aop:InitializeAOP", function(zone)
	InitializeAOP(zone)
end)

RegisterNetEvent("aop:SetStatus")
AddEventHandler("aop:SetStatus", function(status)
	ready = status
end)

RegisterNetEvent("aop:UpdateInformation")
AddEventHandler("aop:UpdateInformation", function(info)
	peacetime 	= 	info[1]
	priority 	=  	info[2]
end)