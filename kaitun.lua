-- ✅ Auto AFK Join Script - Chuẩn để chạy autoexec hoặc loadstring từ GitHub
repeat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer

setfpscap(10) -- Giới hạn FPS giúp nhẹ máy khi AFK

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Đợi ButtonsModule load
local success, ButtonsModule = pcall(function()
	return require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ButtonsModule"))
end)

if not success then
	warn("[❌] Không thể load ButtonsModule. Chắc chắn bạn đang ở đúng game!")
	return
end

-- Hàm Join AFK Zone
local function JoinAfk()
	local ok, err = pcall(function()
		ButtonsModule.AfkTpButtons("Yes")
	end)

	if ok then
		print("[✅] Đã vào khu AFK thành công.")
	else
		warn("[⚠️] Gặp lỗi khi vào khu AFK:", err)
	end
end

-- Theo dõi liên tục, tự vào lại nếu bị out
task.spawn(function()
	while true do
		JoinAfk()
		task.wait(15)
	end
end)
