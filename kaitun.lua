-- ✅ Auto AFK Join Script - Safe để chạy autoexec hoặc loadstring từ GitHub

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

setfpscap(10) -- Giới hạn FPS khi AFK để nhẹ máy

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Chờ và load ButtonsModule an toàn
local ButtonsModule
local success, err = pcall(function()
	local SharedModules = ReplicatedStorage:WaitForChild("SharedModules", 10)
	if SharedModules then
		ButtonsModule = require(SharedModules:WaitForChild("ButtonsModule", 10))
	end
end)

if not success or not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule. Hãy chắc chắn bạn đang ở đúng game!")
	return
end

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

-- Theo dõi và tự vào lại nếu bị out (không chạy nếu đang ở dungeon)
task.spawn(function()
	while true do
		local inDungeon = player:GetAttribute("InDungeon")
		if not inDungeon then
			JoinAfk()
		else
			print("[ℹ️] Đang trong dungeon - không vào lại khu AFK.")
		end
		task.wait(15)
	end
end)
