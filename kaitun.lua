-- ✅ Auto AFK Join Script - Chuẩn để chạy autoexec hoặc loadstring
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
local player = game.Players.LocalPlayer

-- Chờ cho PlayerGui và ReplicatedStorage load hoàn tất
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage")
repeat task.wait() until game.ReplicatedStorage:FindFirstChild("SharedModules")

setfpscap(10) -- Giới hạn FPS giúp nhẹ máy khi AFK

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- An toàn require ButtonsModule
local ButtonsModule
local success, err = pcall(function()
	local SharedModules = ReplicatedStorage:WaitForChild("SharedModules", 10)
	if SharedModules then
		local btn = SharedModules:WaitForChild("ButtonsModule", 10)
		if btn then
			ButtonsModule = require(btn)
		end
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

-- Tự vào lại nếu bị out
task.spawn(function()
	while true do
		JoinAfk()
		task.wait(15) -- Khoảng cách mỗi lần check
	end
end)
