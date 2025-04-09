-- ✅ Auto AFK Join Script - Sẵn sàng cho autoexec hoặc loadstring
-- Tối ưu delay & xử lý lỗi module chưa load

task.wait(2) -- Cho executor và game có thời gian inject script

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

setfpscap(10) -- Giới hạn FPS khi AFK để giảm tài nguyên máy

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

print("[🔃] Đang chờ load ButtonsModule...")

-- Load an toàn ButtonsModule từ SharedModules
local ButtonsModule
local success, err = pcall(function()
	local SharedModules = ReplicatedStorage:WaitForChild("SharedModules", 30)
	if SharedModules then
		ButtonsModule = require(SharedModules:WaitForChild("ButtonsModule", 30))
	end
end)

if not success or not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule:", err or "Không rõ lỗi")
	return
end

print("[✅] Đã load ButtonsModule thành công.")

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

-- Vòng lặp kiểm tra và tự join lại khu AFK nếu cần
task.spawn(function()
	while true do
		JoinAfk()
		task.wait(15) -- Kiểm tra lại mỗi 15 giây
	end
end)
