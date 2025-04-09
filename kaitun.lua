-- ✅ Auto AFK Join Script - Cực kỳ an toàn cho autoexec / loadstring
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
local player = game.Players.LocalPlayer

-- Chờ các phần tử GUI và storage sẵn sàng
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage")

setfpscap(10)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonsModule
local maxWaitTime = 15
local waited = 0

-- Chờ SharedModules và ButtonsModule thực sự tồn tại
while waited < maxWaitTime do
	local success, result = pcall(function()
		local shared = ReplicatedStorage:FindFirstChild("SharedModules")
		if shared then
			local btn = shared:FindFirstChild("ButtonsModule")
			if btn then
				return require(btn)
			end
		end
	end)

	if success and result then
		ButtonsModule = result
		break
	end

	waited += 1
	task.wait(1)
end

if not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule sau 15 giây. Có thể bạn đang không ở đúng game hoặc game chưa load xong.")
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

-- Lặp lại mỗi 15s nếu bị out
while true do
	pcall(JoinAfk)
	task.wait(15)
end
