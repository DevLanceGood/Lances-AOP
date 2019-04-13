config = {
    zones = {
        ["Sandy Shores"] = {
            cmd                 = "ss", -- You use this as the argument for the AOP change. (usage: /aop [cmd]) CMD CANNOT BE "list", "start", "stop", "peacetime", or "priority".
            location            = {x = 1410.51, y = 3122.768, z = 40.55616},
            color               = {r = 255, g = 0, b = 0, a = 100}, -- Red (0-255), Blue (0-255), Green (0-255), Transparancy (0-255)
            visabilitydistance  = 1500, -- You will see the zone's boundaries when you are this far away from the boundaries.
            radius              = 1500 -- The zone's radius.
        },
        ["Blandy Shores"] = {
            cmd                 = "bs", -- You use this as the argument for the AOP change. (usage: /aop [cmd]) CMD CANNOT BE "list", "start", "stop", "peacetime", or "priority".
            location            = {x = 1709.0, y = 3776.0, z = 34.0},
            color               = {r = 255, g = 0, b = 0, a = 100}, -- Red (0-255), Blue (0-255), Green (0-255), Transparancy (0-255)
            visabilitydistance  = 100, -- You will see the zone's boundaries when you are this far away from the boundaries.
            radius              = 100 -- The zone's radius.
        },
    },
    admins = {
        'steam:11000010ce19afe', -- Remove this unless you want to honor my existance
        'steam:110000114192c42', -- Remove this unless you want to honor my existance
    },
    aopdisplay = {x = 0.660, y = 1.370},
    defaultaop = "Sandy Shores", -- The zone name that is loaded on the server's launch.
    killswitchcode = "yunggood" -- DOING "/aop [killswitchcode]" WILL STOP THE ADDON FROM ENFORCING BOUNDARIES AND DISPLAYING MARKERS. YOU CAN TYPE THE CODE AGAIN TO RE-ENABLE THE RESOURCE, BUT YOU WILL BE SENT TO THE DEFAULT AOP.
}