-- Kiểm tra nếu getgenv() chưa có giá trị, đặt mặc định
if not getgenv().Message then
    getgenv().Message = {
        "Default message 1",
        "Default message 2"
    }
end

if not getgenv().SoLan then getgenv().SoLan = 1 end
if not getgenv().MinDelay then getgenv().MinDelay = 3 end
if not getgenv().MaxDelay then getgenv().MaxDelay = 8 end
if not getgenv().MaxMessages then getgenv().MaxMessages = 20 end
if not getgenv().RestTime then getgenv().RestTime = 30 end

-- Hàm chọn tin nhắn ngẫu nhiên
function getRandomMessage()
    return getgenv().Message[math.random(1, #getgenv().Message)]
end

-- Hàm chọn thời gian ngẫu nhiên
function getRandomDelay()
    return math.random(getgenv().MinDelay, getgenv().MaxDelay)
end

-- Bắt đầu vòng lặp spam chat với bảo vệ chống ban
while true do
    local count = 0  -- Reset số lần spam mỗi vòng

    while count < getgenv().MaxMessages do
        wait(getRandomDelay()) -- Đợi thời gian ngẫu nhiên trước khi gửi
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getRandomMessage(), "All")
        count = count + 1
    end

    -- Sau khi đạt MaxMessages, nghỉ trong một khoảng thời gian trước khi tiếp tục
    print("⏸️ Đang nghỉ " .. getgenv().RestTime .. " giây trước khi tiếp tục spam...")
    wait(getgenv().RestTime)
end
