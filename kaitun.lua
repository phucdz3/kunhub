-- ✅ Auto AFK Join Script - Ổn định cho autoexec/loadstring
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
local player = game.Players.LocalPlayer

-- Chờ PlayerGui và SharedModules load
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage")
repeat task.wait() until game.ReplicatedStorage:FindFirstChild("SharedModules")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Tìm ButtonsModule bằng vòng lặp an toàn
local ButtonsModule = nil
for _ = 1, 60 do -- chờ tối đa 60 giây
	local success, result = pcall(function()
		local btn = ReplicatedStorage:WaitForChild("SharedModules", 5):FindFirstChild("ButtonsModule")
		if btn then
			return require(btn)
		end
	end)
	if success and result then
		ButtonsModule = result
		break
	end
	task.wait(1)
end

-- Kiểm tra có load được chưa
if not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule. Hãy chắc chắn bạn đang ở đúng game!")
	return
end

setfpscap(10)

-- Hàm vào khu AFK
local function JoinAfk()
	local ok, err = pcall(function()
		ButtonsModule.AfkTpButtons("Yes")
	end)
	if ok then
		print("[✅] Đã vào khu AFK.")
	else
		warn("[⚠️] Lỗi khi vào khu AFK:", err)
	end
end

-- Theo dõi và vào lại nếu bị out
task.spawn(function()
	while true do
		pcall(JoinAfk)
		task.wait(15)
	end
end)
