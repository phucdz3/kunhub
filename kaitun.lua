task.spawn(function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer

	-- Module chứa logic nút
	local ButtonsModule = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ButtonsModule"))

	-- Hàm kiểm tra có đang ở khu AFK không (giả sử có giá trị trong leaderstats)
	local function isInAfkZone()
		local leaderstats = player:FindFirstChild("leaderstats")
		if leaderstats then
			local afk = leaderstats:FindFirstChild("AfkRewards")
			return afk and afk.Value > 0 -- Ví dụ: nếu đã nhận reward thì đang trong AFK
		end
		return false
	end

	-- Hàm Join AFK
	local function JoinAfk()
		print("[⏳] Đang cố gắng vào khu AFK...")
		local success, err = pcall(function()
			ButtonsModule.AfkTpButtons("Yes")
		end)

		if success then
			print("[✅] Đã vào khu AFK thành công.")
		else
			warn("[⚠️] Lỗi khi vào khu AFK: ", err)
		end
	end

	-- Kiểm tra định kỳ
	while true do
		if not isInAfkZone() then
			print("[🔁] Bạn đã bị out khỏi AFK, đang tự động vào lại...")
			JoinAfk()
		end
		task.wait(10)
	end
end)
