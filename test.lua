local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- check có phải Draco V4 chưa
local function IsDraco()
    local data = player:FindFirstChild("Data")
    if not data then return false end

    local race = data:FindFirstChild("Race")
    if not race then return false end
    if not race:FindFirstChild("Evolved") then return false end

    return race.Value == "Draco"
end

local function CheckRaceDracoStatus()
    if not IsDraco() then
        return "Bạn chưa thức tỉnh Draco."
    end

    -- GIỐNG BANANA: dùng TempleClock / Check
    local ok, info = pcall(function()
        return CommF:InvokeServer("TempleClock", "Check")
    end)

    if not ok or type(info) ~= "table" or info.Race ~= "Draco" then
        return "Không đọc được dữ liệu Draco."
    end

    local level    = tonumber(info.RaceLevel) or 0
    local hadPoint = info.HadPoint == true
    local details  = info.RaceDetails or {}
    local A = tonumber(details.A) or 0
    local B = tonumber(details.B) or 0
    local C = tonumber(details.C) or 0 -- Energy Training tier

    -- ----- mapping trạng thái giống logic Draco -----

    -- chưa đủ level Draco
    if level < 2 then
        return "RaceLevel " .. level .. " – Bạn cần train Draco thêm."
    end

    -- đã max Energy Training (C cao)
    if C >= 3 then
        return "Draco gần như hoàn thành (Energy Training Tier " .. C .. ")."
    end

    -- vừa clear trial, đang có point để đổi ember
    if hadPoint then
        return "Có Draco Point – hãy vào Draco room để đổi ember."
    end

    -- không có point → phải đi làm trial tiếp
    return "Ready For Trial."
end

-- Update GUI
local function UpdateDracoGUI()
    nameLabel.Text = "Tên: " .. player.Name

    local success, result = pcall(CheckRaceDracoStatus)
    if success then
        statusLabel.Text = "Draco: " .. result
    else
        statusLabel.Text = "Draco: Không đọc được dữ liệu Draco."
    end
end
