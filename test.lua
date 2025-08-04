repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
getgenv().Key = "3df5493413a543e9572eb8b5"
getgenv().Config = {
    ["Pet"] = {
        ["Name Pet"] = {"Kitsune","Butterfly","Dragonfly","Capybara","Ostrich","Mimic Octopus"}, -- Enter the name of the pet you like; if there's an egg available, it will automatically purchase it.
        ["Auto Mutation Pet"] = {}, -- Enter the mutation of the pet you want — once you have the pet, it will automatically farm and insert it into the machine  
        ["Delete Pet Other"] = true, -- It will delete other pets that do not have the name in name pet
    },
    ["Webhook"] = {
        ["Enabled"] = false,
        ["Url"] = "",
        ["Webhook Profile"] = true,
        ["Webhook Collect Egg"] = true,
    },
    ["Boost FPS"] = {
        ["Set FPS"] = {
            ["Enabled"] = true,
            ["FPS"] = 10
        },
        ["White Screen"] = false,
        ["Black Screen"] = false,
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/refs/heads/main/KaitunGAG.lua"))()
