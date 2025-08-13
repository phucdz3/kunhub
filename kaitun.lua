-- Cấu hình
local min_delay = 3   -- Độ trễ tối thiểu giữa các tin nhắn (giây)
local max_delay = 10  -- Độ trễ tối đa giữa các tin nhắn (giây)
local max_messages = 2 -- Số lần spam trước khi tạm dừng
local rest_time = 300 -- Thời gian nghỉ trước khi tiếp tục spam (giây)

-- Danh sách tin nhắn ngẫu nhiên để tránh bị phát hiện
local messages = {
    "🔥 Cheap fruits at saleroblox n e t 🍎",
    "💎 Best deals only at saleroblox n e t 💰",
}

-- Hàm chọn tin nhắn ngẫu nhiên
function getRandomMessage()
    return messages[math.random(1, #messages)]
end

-- Hàm chọn thời gian chờ ngẫu nhiên
function getRandomDelay()
    return math.random(min_delay, max_delay)
end

-- Bắt đầu vòng lặp spam chat với bảo vệ chống ban
while true do
    local count = 0 -- Reset số lần spam mỗi vòng

    while count < max_messages do
        wait(getRandomDelay()) -- Đợi thời gian ngẫu nhiên trước khi gửi
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getRandomMessage(), "All")
        count = count + 1
    end

    -- Sau khi đạt max_messages, nghỉ trong một khoảng thời gian trước khi tiếp tục
    print("⏸️ Đang nghỉ " .. rest_time .. " giây trước khi tiếp tục spam...")
    wait(rest_time)
end
