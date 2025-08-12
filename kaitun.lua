script_key = "lqFgIriDBpHgeNWRiUsuhNtdrkkHIGbm"
getgenv().SetFpsCap = true
getgenv().FpsCap = 10
getgenv().OneClickUi = true -- Only Open Necessacry Ui For One Click
getgenv().FpsBoost1 = true
    getgenv().WhiteScreen = false
    getgenv().UiCheckItems = false
    getgenv().OneClickSetting = {
        Enable=true,
        UnlimitGetQuest=true,
        TripleQuest=true,
        AutoAddStats=true,
        RedeemCode=true,
        Sea2KeyHop=true,
        FruitEat = { --Priority, Name, 
            [1] = {"Magma-Magma"},
            [2] = {"Magma-Magma"}
        },
        EatFruitFromStorage = false,
        SnipeFruit = false,
        SnipeFruitMirage = false,
        HopIfFoundNearExploiter = false,
        HopHakiColor =false,
        HopTushita = false,
        HopValkyriehelm = false,
        HopMirrorFractal=false,
        FarmPole = false, -- Turn off If Want Focus Level
        FarmItems = false, --Turn off If Want Focus Level And CDK, THis Only get After You Get God Human
        DisableSoulGuitar = true,
        DisableCDK = true,
        DisableRaceEvolve = true,

    }
    getgenv().OneClickFarms = {
        ["Shark Anchor"] = false,
    }
getgenv().Team = "Pirates"
getgenv().AutoLoad = false --Will Load Script On Server Hop
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/85e904ae1ff30824c1aa007fc7324f8f.lua"))()
