RegisterCommand("aop", function(source, args, rawCommand)
    if (args[1] == "list") then 
        TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "List of AOP Options:")
        TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        for k,v in pairs(config.zones) do
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, k .. ": " .. v.cmd)
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        end
    elseif (args[1] == config.killswitchcode) then 
        TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "Ending AOP restrictions.")
        TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        for k,v in pairs(config.zones) do
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, k .. ": " .. v.cmd)
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        end
    else
        local cmd = args[1]
        local zone = nil
        for k,v in pairs(config.zones) do
            if (v.cmd == cmd) then
                zone = v
                zone.name = k
                break
            end
        end
        if (zone ~= nil) then
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "Changing the AOP to ^2" .. zone.name .. "^0.")
            TriggerClientEvent('chatMessage', -1, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
            TriggerClientEvent('aop:InitializeAOP', -1, zone)
        else
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "^1ERROR!^0 The AOP was not found, do \"/aop list\" to see all available options.")
            TriggerClientEvent('chatMessage', source, "[Lance's AOP]", {30, 144, 255}, "----------------------------------")
        end
    end
end, false) -- set this to false to allow anyone.