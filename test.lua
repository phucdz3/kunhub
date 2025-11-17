-- GUI hiển thị trạng thái Race Draco
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaceDracoStatusGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Tạo khung viền (Frame)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 330, 0, 60)
frame.Position = UDim2.new(0.5, -165, 0, 20) -- giữa màn hình, phía trên
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 2
frame.Parent = screenGui

-- Label tên người chơi
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1, -20, 0.5, -5)
nameLabel.Position = UDim2.new(0, 10, 0, 5)
nameLabel.BackgroundTransparency = 1
nameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.Text = "Tên: Đang tải..."
nameLabel.Parent = frame

-- Label trạng thái train Draco
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0.5, -5)
statusLabel.Position = UDim2.new(0, 10, 0.5, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Text = "Draco: Đang kiểm tra..."
statusLabel.Parent = frame

-- ===== HÀM CHECK DRACO =====
local function IsDraco()
    local data = player:FindFirstChild("Data")
    if not data then return false end

    local race = data:FindFirstChild("Race")
    if not race then return false end

    if not race:FindFirstChild("Evolved") then
        return false
    end

    return race.Value == "Draco"
end

local function CheckRaceDracoStatus()
    -- chưa Draco / chưa V4 Draco
    if not IsDraco() then
        return "Bạn chưa thức tỉnh Draco."
    end

    -- GỌI GIỐNG V4: UpgradeRace / Check
    local ok, status, current, fragment = pcall(function()
        return CommF:InvokeServer("UpgradeRace", "Check")
    end)

    if not ok or status == nil then
        return "Không đọc được dữ liệu Draco."
    end

    -- status / current / fragment giống Race V4
    if status == 1 or status == 3 then
        return "Bạn cần train Draco thêm."
    elseif status == 2 or status == 4 or status == 7 then
        return "Có thể mua Draco gear với " .. tostring(fragment) .. " mảnh."
    elseif status == 5 then
        return "Bạn đã hoàn thành Draco."
    elseif status == 6 then
        return "Đã nâng Draco: " .. tostring(current - 2) .. "/3. Cần train thêm."
    elseif status == 8 then
        return "Còn " .. tostring(10 - current) .. " buổi train Draco."
    elseif status == 0 then
        return "Sẵn sàng cho Draco Trial."
    else
        return "Không đọc được dữ liệu Draco."
    end
end

-- ===== CẬP NHẬT GUI =====
local function UpdateDracoGUI()
    nameLabel.Text = "Tên: " .. player.Name

    local success, result = pcall(CheckRaceDracoStatus)
    if success then
        statusLabel.Text = "Draco: " .. result
    else
        statusLabel.Text = "Draco: Không đọc được dữ liệu Draco."
    end
end

-- Cập nhật ban đầu
UpdateDracoGUI()

-- Cập nhật tự động mỗi 10 giây
task.spawn(function()
    while true do
        task.wait(10)
        UpdateDracoGUI()
    end
end)
