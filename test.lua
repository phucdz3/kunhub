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

-- Label trạng thái Draco
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

-- Hàm check có phải Draco đã evolve chưa
local function IsDraco()
    local data = player:FindFirstChild("Data")
    if not data then return false end

    local race = data:FindFirstChild("Race")
    if not race then return false end

    if not race:FindFirstChild("Evolved") then return false end

    return race.Value == "Draco"
end

-- Hàm kiểm tra Race Draco
local function CheckRaceDracoStatus()
    if not IsDraco() then
        return "Bạn không phải Race Draco hoặc chưa thức tỉnh Draco."
    end

    -- Gọi đúng remote TempleClock, dựa theo script bạn gửi
    local ok, info = pcall(function()
        return CommF:InvokeServer("TempleClock", "Check")
    end)

    if not ok or type(info) ~= "table" or info.Race ~= "Draco" then
        return "Không đọc được dữ liệu Draco."
    end

    local level   = tonumber(info.RaceLevel) or 0
    local hadPoint = info.HadPoint == true

    local details = info.RaceDetails or {}
    local A = tonumber(details.A) or 0          -- số ember Alpha
    local B = tonumber(details.B) or 0          -- số ember Omega
    local C = tonumber(details.C) or 0          -- Energy Training tier (Gear5)
    local totalEmber = math.clamp(A + B, 0, 3)  -- tối đa 3 ember

    -- Ghép text hiển thị
    local parts = {}

    table.insert(parts, ("Lv.%d"):format(level))
    table.insert(parts, ("Ember: %d/3 (A:%d | O:%d)"):format(totalEmber, A, B))

    if C > 0 then
        table.insert(parts, ("Energy Training: Tier %d"):format(C))
    else
        table.insert(parts, "Energy Training: Chưa mở")
    end

    if hadPoint then
        table.insert(parts, "Đang có điểm để đổi ember.")
    else
        table.insert(parts, "Không có điểm đổi ember.")
    end

    return table.concat(parts, " | ")
end

-- Hàm cập nhật GUI
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
