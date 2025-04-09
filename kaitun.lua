-- ✅ Auto AFK Join Script - Fix lỗi require và coroutine khi chạy autoexec/loadstring
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer

-- Đợi PlayerGui & ReplicatedStorage & SharedModules
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage") and game.ReplicatedStorage:FindFirstChild("SharedModules")

setfpscap(10) -- Giới hạn FPS khi AFK

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonsModule

-- Đợi an toàn và require module
local function waitForModule()
	for i = 1, 50 do
		local success, result = pcall(function()
			local SharedModules = ReplicatedStorage:FindFirstChild("SharedModules")
			local btn = SharedModules and SharedModules:FindFirstChild("ButtonsModule")
			if btn then
				return require(btn)
			end
		end)

		if success and result then
			return result
		end
		task.wait(0.2)
	end
	return nil
end

ButtonsModule = waitForModule()

if not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule. Hãy chắc chắn bạn đang ở đúng game!")
	return
end

-- Hàm vào khu AFK an toàn
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

-- Theo dõi liên tục mà không chết coroutine
task.defer(function()
	while true do
		pcall(JoinAfk)
		task.wait(15)
	end
end)
