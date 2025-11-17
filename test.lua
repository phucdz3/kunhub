-- GUI hiển thị trạng thái Race Draco
local player = game.Players.LocalPlayer

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

-- Label trạng thái train
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

-- Hàm kiểm tra Race Draco
local function CheckRaceDracoStatus()
    if not player.Character then
        return "Không tìm thấy nhân vật."
    end

    -- Nếu game của bạn có cách check Draco khác thì sửa dòng bên dưới:
    -- Ví dụ: ("UpgradeDraco", "Check") hoặc ("DracoRace", "Check") tùy game
    local status, current, fragment = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeDraco", "Check")

    if status == nil then
        return "Không đọc được dữ liệu Draco."
    end

    -- Map giống Race V4 nhưng đổi text sang Draco
    if status == 1 or status == 3 then
        return "Bạn cần train Draco thêm."
    elseif status == 2 or status == 4 or status == 7 then
        return "Có thể mua Draco Gear với " .. tostring(fragment) .. " mảnh."
    elseif status == 5 then
        return "Bạn đã hoàn thành Draco."
    elseif status == 6 then
        return "Đã nâng Draco: " .. tostring(current - 2) .. "/3. Cần train thêm."
    elseif status == 8 then
        return "Còn " .. tostring(10 - current) .. " buổi train Draco."
    elseif status == 0 then
        return "Sẵn sàng làm Draco Trial."
    else
        return "Không đọc được dữ liệu Draco."
    end
end

-- Hàm cập nhật GUI
local function UpdateDracoGUI()
    nameLabel.Text = "Tên: " .. player.Name

    local success, result = pcall(CheckRaceDracoStatus)
    if success then
        statusLabel.Text = "Draco: " .. result
    else
        statusLabel.Text = "Draco: Không đọc được dữ liệu"
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
