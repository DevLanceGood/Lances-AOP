config = {
    zones = {
        ["Sandy Shores"] = {
            cmd         = "ss", -- You use this as the argument for the AOP change. (usage: /aop [cmd]) CANNOT BE "list"
            location    = {x = 1809.0, y = 3676.0, z = 34.0},
            color       = {r = 255, g = 0, b = 0, a = 100}, -- Red (0-255), Blue (0-255), Green (0-255), Transparancy (0-255)
            visabilitydistance = 100, -- You will see the zone's boundaries when you are this far away from the boundaries.
            height      = 3000, -- NOTE: YOUR HEIGHT JUST EFFECTS YOUR MARKER'S DISPLAYED HEIGHT. RADIUS AUTOMATICALLY USES ITS NUMBER AS THE ACTUAL DETECTION HEIGHT. (MAKE IT 1000+)
            radius      = 3000 -- The zone's radius.
        },
    },
    defaultzone = "Sandy Shores",
    killswitchcode = "yunggood" -- DOING "/aop [killswitchcode]" WILL STOP THE ADDON FROM ENFORCING BOUNDARIES AND DISPLAYING MARKERS. YOU CAN TYPE THE CODE AGAIN TO RE-ENABLE THE RESOURCE, BUT YOU WILL BE SENT TO THE DEFAULT AOP.
}