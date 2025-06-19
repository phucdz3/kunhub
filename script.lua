local min_delay = 3  -- Độ trễ tối thiểu giữa các tin nhắn (giây)
local max_delay = 10  -- Độ trễ tối đa giữa các tin nhắn (giây)
local max_messages = 1 -- Số lần spam trước khi tạm dừng
local min_rest = 50  -- Thời gian nghỉ tối thiểu (giây)
local max_rest = 150  -- Thời gian nghỉ tối đa (giây)

-- Danh sách tin nhắn gửi theo thứ tự
local messages = {
    "shop kitsune yeti leopard - saleroblox n e t"
}

-- Biến đếm vị trí tin nhắn hiện tại
local messageIndex = 1

-- Hàm lấy tin nhắn theo thứ tự
function getNextMessage()
    local message = messages[messageIndex]
    messageIndex = messageIndex + 1
    if messageIndex > #messages then
        messageIndex = 1  -- Quay lại tin nhắn đầu tiên khi hết danh sách
    end
    return message
end

-- Hàm chọn thời gian chờ ngẫu nhiên
function getRandomDelay()
    return math.random(min_delay, max_delay)
end

-- Hàm chọn thời gian nghỉ ngẫu nhiên
function getRandomRest()
    return math.random(min_rest, max_rest)
end

-- Bắt đầu vòng lặp spam chat với bảo vệ chống ban
while true do
    local count = 0  -- Reset số lần spam mỗi vòng

    while count < max_messages do
        task.wait(getRandomDelay()) -- Đợi thời gian ngẫu nhiên trước khi gửi
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getNextMessage(), "All")
        count = count + 1
    end

    -- Sau khi đạt max_messages, nghỉ trong một khoảng thời gian trước khi tiếp tục
    local rest_time = getRandomRest()
    print("⏸️ Đang nghỉ " .. rest_time .. " giây trước khi tiếp tục spam...")
    task.wait(rest_time)
end
