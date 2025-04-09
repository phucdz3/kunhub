task.spawn(function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer

	-- Đợi module Buttons load
	local ButtonsModule = require(ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("ButtonsModule"))

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

	-- Lặp lại kiểm tra mỗi 10 giây
	while true do
		JoinAfk()
		task.wait(10)
	end
end)
