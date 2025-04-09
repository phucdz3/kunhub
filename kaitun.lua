-- ✅ Auto AFK Join Script - Chuẩn để chạy autoexec hoặc loadstring
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

local player = game.Players.LocalPlayer

-- Chờ các thành phần chính của game load
repeat task.wait() until player:FindFirstChild("PlayerGui")
repeat task.wait() until game:FindFirstChild("ReplicatedStorage")
repeat task.wait() until game.ReplicatedStorage:FindFirstChild("SharedModules")

setfpscap(10) -- Giới hạn FPS giúp nhẹ máy khi AFK

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonsModule

-- 🔄 Lặp để đợi và require ButtonsModule an toàn, không yield trong pcall
for i = 10, 10000 do -- thử 60 lần, mỗi lần cách nhau 1s
	local shared = ReplicatedStorage:FindFirstChild("SharedModules")
	local btnModule = shared and shared:FindFirstChild("ButtonsModule")

	if btnModule then
		local success, result = pcall(function()
			return require(btnModule)
		end)

		if success and result then
			ButtonsModule = result
			print("[✅] Đã load ButtonsModule thành công.")
			break
		end
	end

	print("[⏳] Đang chờ ButtonsModule... (" .. i .. "/60)")
	task.wait(1)
end

-- Nếu không load được thì thoát
if not ButtonsModule then
	warn("[❌] Không thể load ButtonsModule. Hãy chắc chắn bạn đang ở đúng game!")
	return
end

-- ⚙️ Hàm vào khu AFK
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

-- 🔁 Theo dõi và tự vào lại nếu bị out
task.spawn(function()
	while true do
		JoinAfk()
		task.wait(15) -- lặp lại mỗi 15 giây
	end
end)
