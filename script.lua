-- Cấu hình
local min_delay = 3  -- Độ trễ tối thiểu giữa các tin nhắn (giây)
local max_delay = 8  -- Độ trễ tối đa giữa các tin nhắn (giây)
local max_messages = 20 -- Số lần spam trước khi tự dừng

-- Danh sách tin nhắn ngẫu nhiên để tránh bị phát hiện
local messages = {
    "fruits cheap at saleroblox. n e t"
}

-- Đếm số lần gửi tin nhắn
local count = 0

-- Hàm chọn tin nhắn ngẫu nhiên
function getRandomMessage()
    return messages[math.random(1, #messages)]
end

-- Hàm chọn thời gian ngẫu nhiên
function getRandomDelay()
    return math.random(min_delay, max_delay)
end

-- Bắt đầu vòng lặp spam chat với bảo vệ chống ban
while count < max_messages do
    wait(getRandomDelay()) -- Đợi thời gian ngẫu nhiên
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getRandomMessage(), "All")
    count = count + 1
end

print("⚠️ Script đã tự động dừng sau " .. max_messages .. " lần spam để tránh bị ban.")
