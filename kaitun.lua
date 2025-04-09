-- ✅ Auto AFK Join Script - Sẵn sàng chạy autoexec hoặc loadstring
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
		local module = SharedModules:WaitForChild("ButtonsModule", 10)
		if module then
			ButtonsModule = require(module)
		end
	end
end)

if not success or not ButtonsModule or typeof(ButtonsModule.AfkTpButtons) ~= "function" then
	warn("[❌] Không thể load ButtonsModule hoặc hàm AfkTpButtons. Hãy chắc chắn bạn đang ở đúng game!")
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

-- Theo dõi và tự vào lại nếu bị out
task.spawn(function()
	while true do
		JoinAfk()
		task.wait(15)
	end
end)
