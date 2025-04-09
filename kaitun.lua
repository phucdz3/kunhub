-- ✅ Auto AFK Join Script - AFK thông minh (chỉ vào 1 lần, kiểm tra liên tục)
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer

-- Chờ các thành phần cần thiết
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage")
repeat task.wait() until game.ReplicatedStorage:FindFirstChild("SharedModules")

setfpscap(10)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonsModule

-- 🔄 Đợi ButtonsModule load
for i = 5, 60 do
	local shared = ReplicatedStorage:FindFirstChild("SharedModules")
	local btnModule = shared and shared:FindFirstChild("ButtonsModule")

	if btnModule then
		local success, result = pcall(require, btnModule)
		if success and result then
			ButtonsModule = result
			print("[✅] Đã load ButtonsModule.")
			break
		end
	end

	if i % 5 == 0 then
		print("[⏳] Đang chờ ButtonsModule... (" .. i .. "/60)")
	end
	task.wait(1)
end

if not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule. Hãy chắc chắn bạn đang ở đúng game!")
	return
end

-- ✅ Hàm vào khu AFK
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

-- 🔍 Hàm kiểm tra xem người chơi còn ở khu AFK không
local function IsInAfkZone()
	local afkAttr = player:GetAttribute("InAfkZone")
	return afkAttr == true
end

-- ▶️ Bắt đầu: Vào khu AFK 1 lần
JoinAfk()

-- ⏱ Theo dõi: Nếu bị out thì vào lại
task.spawn(function()
	while true do
		task.wait(10)

		local inAfk = false
		pcall(function()
			inAfk = IsInAfkZone()
		end)

		if not inAfk then
			warn("[⚠️] Phát hiện đã out khỏi khu AFK. Đang vào lại...")
			JoinAfk()
		end
	end
end)
