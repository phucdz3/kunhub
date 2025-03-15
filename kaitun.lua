local Players = game:GetService("Players") -- Lấy danh sách người chơi
local LocalPlayer = Players.LocalPlayer -- Lấy người chơi hiện tại

local queue = {} -- Danh sách hàng đợi gửi kết bạn
local sentRequests = {} -- Lưu danh sách người đã gửi lời mời
local isProcessing = true -- Kiểm soát trạng thái gửi kết bạn
local DELAY_TIME = 1000 -- ⏳ Thời gian chờ giữa mỗi lần gửi kết bạn (tùy chỉnh)

function sendFriendRequest(targetPlayer)
    if targetPlayer ~= LocalPlayer and not sentRequests[targetPlayer.UserId] then
        table.insert(queue, targetPlayer) -- Thêm vào hàng đợi
        sentRequests[targetPlayer.UserId] = true -- Đánh dấu đã gửi kết bạn
        processQueue() -- Bắt đầu xử lý hàng đợi
    end
end

function processQueue()
    if isProcessing or #queue == 0 then return end -- Nếu đang xử lý, không làm gì cả
    
    isProcessing = true -- Đánh dấu đang xử lý
    local player = table.remove(queue, 1) -- Lấy người đầu tiên trong hàng đợi

    LocalPlayer:RequestFriendship(player)
    print("📨 Đã gửi kết bạn đến:", player.Name)

    wait(DELAY_TIME) -- ⏳ Chờ theo thời gian được đặt trước
    isProcessing = false -- Đánh dấu đã xử lý xong
    processQueue() -- Gọi lại để xử lý tiếp theo trong hàng đợi
end

-- Thêm tất cả người chơi hiện tại vào danh sách gửi kết bạn
for _, player in pairs(Players:GetPlayers()) do
    sendFriendRequest(player)
end

-- Khi có người chơi mới vào, thêm vào hàng đợi
Players.PlayerAdded:Connect(function(player)
    wait(2) -- Đợi 2 giây trước khi gửi kết bạn
    sendFriendRequest(player)
end)
