repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer

setfpscap(10)

-- Code chính ở đây (VD: tự join AFK)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ButtonsModule = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ButtonsModule"))

local function JoinAfk()
    print("[⏳] Đang cố gắng vào khu AFK...")
    local success, err = pcall(function()
        ButtonsModule.AfkTpButtons("Yes")
    end)

    if success then
        print("[✅] Đã vào khu AFK thành công.")
    else
        warn("[⚠️] Lỗi khi vào khu AFK: ", err)
    end
end

-- Tự động vào lại nếu bị out
task.spawn(function()
    while true do
        JoinAfk()
        task.wait(15)
    end
end)
