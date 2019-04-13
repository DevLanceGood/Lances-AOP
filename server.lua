local currentzone = config.zones[config.defaultaop]
local currentzonename = config.defaultaop
local peacetime = 0
local priority = false
local status = true

RegisterNetEvent("aop:UpdateClientAOP")
AddEventHandler("aop:UpdateClientAOP", function()
    currentzone.name = currentzonename
    TriggerClientEvent('aop:InitializeAOP', source, currentzone)
    TriggerClientEvent("aop:UpdateInformation", source, {peacetime, priority})
end)

Citizen.CreateThread(function()
    while true do
        if (peacetime > 0) then
            peacetime = peacetime - 1
            TriggerClientEvent("aop:UpdateInformation", -1, {peacetime, priority})
        end
        Citizen.Wait(1000)
    end
end)

RegisterCommand("aop", function(source, args, rawCommand)
    if (isAdmin(source)) then
        if (args[1] == "list") then 
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "List of AOP Options:")
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
            for k,v in pairs(config.zones) do
                TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, k .. ": " .. v.cmd)
                TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
            end
        elseif (args[1] == "stop") then 
            status = false
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "Disabling AOP.")
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "The AOP has been disabled.")
            TriggerClientEvent('aop:SetStatus', -1, false)
        elseif (args[1] == "start") then 
            status = true
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "Re-Enabling AOP.")
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "The AOP has been enabled.")
            TriggerClientEvent('aop:SetStatus', -1, true)
        elseif (args[1] == "priority") then
            priority = not priority
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, priority and "There is a Priority in Progress." or "The Priority is now over.")
            TriggerClientEvent("aop:UpdateInformation", -1, {peacetime, priority})
        elseif (args[1] == "peacetime") then
            if (args[2] == nil) then
                TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "^1ERROR!^0 You incorrectly used this command (usage: /aop peacetime [minutes]).")
                return
            end
            peacetime = tonumber(args[2])
            if (peacetime > 30) then
                TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "Some dickhead admin / owner just tried to make you have to suffer peacetime for " .. peacetime .. " minutes!")
                TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "Don't worry, Lance Good is here to save you. Lets make that 30 minutes!")
                peacetime = 30
            end
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "A new Peacetime is now in Progress.")
            TriggerClientEvent("aop:UpdateInformation", -1, {peacetime, priority})
        else
            local cmd = args[1]
            local zone = nil
            for k,v in pairs(config.zones) do
                if (v.cmd == cmd) then
                    zone = v
                    zone.name = k
                    currentzone = zone
                    currentzonename = k
                    break
                end
            end
            if (zone ~= nil) then
                TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "Changing the AOP to ^2" .. zone.name .. "^0.")
                TriggerClientEvent('aop:InitializeAOP', -1, zone)
            else
                TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "^1ERROR!^0 The AOP was not found, do \"/aop list\" to see all available options.")
            end
        end
    end
end, false) -- set this to false to allow anyone.

local function isAdmin(source)
    local allowed = false
    for i,id in ipairs(config.admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(source)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
	end
	if IsPlayerAceAllowed(source, "lance.aop") then
		allowed = true
	end
    return allowed
end