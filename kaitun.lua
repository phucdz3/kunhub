-- ✅ Auto AFK Join Script - Chuẩn fix delay logo
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
local player = game.Players.LocalPlayer

-- Chờ các thành phần quan trọng
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage")
repeat task.wait() until game.ReplicatedStorage:FindFirstChild("SharedModules")
repeat task.wait() until game.ReplicatedStorage.SharedModules:FindFirstChild("ButtonsModule")

setfpscap(10)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonsModule = require(ReplicatedStorage.SharedModules.ButtonsModule)

-- Hàm vào khu AFK
local function JoinAfk()
	local ok, err = pcall(function()
		ButtonsModule.AfkTpButtons("Yes")
	end)

	if ok then
		print("[✅] Đã vào khu AFK thành công.")
	else
		warn("[⚠️] Lỗi khi vào khu AFK:", err)
	end
end

-- Vào lại nếu bị out
while true do
	pcall(JoinAfk)
	task.wait(15)
end
