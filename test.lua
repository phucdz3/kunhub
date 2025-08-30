setfpscap(20)
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
_G.Team = "Pirate" -- Marine / Pirate
getgenv().Script_Mode = "Kaitun_Script"
_G.MainSettings = {
    ["EnabledHOP"] = true,
    ['FPSBOOST'] = true,
    ["FPSLOCKAMOUNT"] = 20,
    ['WhiteScreen'] = true,
    ['CloseUI'] = false,
    ["NotifycationExPRemove"] = true,
    ['AFKCheck'] = 150,
    ["LockFragments"] = 20000,
    ["LockFruitsRaid"] = {
        [1] = "Dough-Dough",
        [2] = "Dragon-Dragon",
        [3] = "Leopard-Leopard",
        [4] = "Gas-Gas",
        [5] = "Yeti-Yeti",
        [6] = "Kitsune-Kitsune",
        [7] = "Lightning-Lightning"
    }
}
_G.SharkAnchor_Settings = {
    ["Enabled_Farm"] = false,
    ['FarmAfterMoney'] = 2500000
}
_G.Quests_Settings = {        
    ['Rainbow_Haki'] = true,
    ["MusketeerHat"] = true,
    ["PullLever"] = false,
    ['DoughQuests_Mirror'] = {
        ['Enabled'] = false,
        ['UseFruits'] = false
    }        
}
_G.Races_Settings = {
    ['Race'] = {
        ['EnabledEvo'] = false,
        ["v2"] = true,
        ["v3"] = true,
        ["Races_Lock"] = {
            ["Races"] = {
                ["Mink"] = true,
                ["Human"] = true,
                ["Fishman"] = true
            },
            ["RerollsWhenFragments"] = 20000
        }
    }
}
_G.Fruits_Settings = {
    ['Main_Fruits'] = {'Magma-Magma'},
    ['Select_Fruits'] = {"Flame-Flame", "Ice-Ice", "Quake-Quake", "Light-Light", "Dark-Dark", "Spider-Spider", "Rumble-Rumble", "Magma-Magma"}
}
_G.Settings_Melee = {
    ['Superhuman'] = true,
    ['DeathStep'] = true,
    ['SharkmanKarate'] = true,
    ['ElectricClaw'] = true,
    ['DragonTalon'] = true,
    ['Godhuman'] = true
}
_G.SwordSettings = {
    ['Saber'] = true,
    ["Pole"] = false,
    ['MidnightBlade'] = false,
    ['Shisui'] = false,
    ['Saddi'] = false,
    ['Wando'] = false,
    ['Yama'] = true,
    ['Rengoku'] = false,
    ['Canvander'] = false,
    ['BuddySword'] = false,
    ['TwinHooks'] = false,
    ['HallowScryte'] = false,
    ['TrueTripleKatana'] = false,
    ['CursedDualKatana'] = false
}
_G.GunSettings = {
    ['Kabucha'] = false,
    ['SerpentBow'] = false,
    ['SoulGuitar'] = false
}
_G.FarmMastery_Settings = {
    ['Melee'] = true,
    ['Sword'] = false,
    ['DevilFruits'] = false,
    ['Select_Swords'] = {
        ["AutoSettings"] = false,
        ["ManualSettings"] = {
            "Saber",
            "Buddy Sword"
        }
    }
}
_G.Hop_Settings = {
    ["Find Tushita"] = false
}
getgenv().Key = "MARU-QMS2M-OROY1-KFWW-0VTSR-C9AL"
getgenv().id = "1101827732343640144"
getgenv().Script_Mode = "Kaitun_Script"
loadstring(game:HttpGet("https://raw.githubusercontent.com/xshiba/MaruBitkub/main/Mobile.lua"))()
