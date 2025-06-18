getgenv().Config = {
	["Server"] = "http://yummydata.click",
	["Server2"] = "https://api-bf.yummydata.click/data-private?type=",
	["Team"] = "Marines",
	["FPS"] = 30,
	["Boost FPS"] = true,
	["Black Screen"] = true,
	["Frag Limit"] = 5000
}
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")
local plr = game.Players.LocalPlayer

local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes");
if plr.Name == "bocanhet164" then getgenv().team = "Marines" end
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") and game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"].Enabled then
	repeat
		wait()
		pcall(function()
			for i, v in getconnections(game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"].ChooseTeam.Container["Marines"].Frame.TextButton.Activated) do
				v.Function()
			end
		end)
		task.wait(3)
	until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhxCKaMPVfef/huhu/refs/heads/master/ui-obfuscated.lua"))()
function getinfoallboss2()
	local success, res = pcall(function()
		return request({
			Url = getgenv().Config["Server2"] .. "Rare%20Boss",
			Method = "GET"
		})
	end)

	if not success or not res or not res.Body then
		warn("Failed to fetch rare boss info from Server2")
		return {}
	end

	local successDecode, data = pcall(function()
		return game:GetService("HttpService"):JSONDecode(res.Body)
	end)

	if not successDecode or not data or next(data) == nil then
		warn("Failed to decode rare boss info or data is empty")
		return {}
	end

	return data
end

local Decrypt = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/ZhxCKaMPVfef/huhu/refs/heads/master/zzzz.lua"))()

function joinserver(id, isbanana)
	if isbanana then
		game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", Decrypt(id))
	else
		game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", id)
	end
end

local Modules = game.ReplicatedStorage:WaitForChild("Modules")

local Net = Modules:WaitForChild("Net")

local RE_RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RE_ShootGunEvent = Net:WaitForChild("RE/ShootGunEvent")
local RE_RegisterHit = Net:WaitForChild("RE/RegisterHit")
local SUCCESS_HIT, HIT_FUNCTION = pcall(function()
	return (getmenv or getsenv)(Net)._G.SendHitsToServer
end)
local plr = game.Players.LocalPlayer
function GetAllBladeHits(Character)
	local CFrame = Character:GetPivot().Position
	local BladeHits, FirstRootPart = {}
	local EnemyList = workspace.Enemies:GetChildren()
	local PlayerList = workspace.Characters:GetChildren()
	for i = 1, #EnemyList do
		local Enemy = EnemyList[i]
		local RootPart = Enemy.PrimaryPart

		if RootPart and game.Players.LocalPlayer:DistanceFromCharacter(RootPart.Position) <= 350 then
			if not FirstRootPart then
				FirstRootPart = RootPart
			else
				table.insert(BladeHits, { Enemy, RootPart, })
			end
		end
	end

	return FirstRootPart, BladeHits
end

local SUCCESS_FLAGS, COMBAT_REMOTE_THREAD = pcall(function()
	return require(Modules.Flags).COMBAT_REMOTE_THREAD or false
end)
local RegisterAttack = Net:WaitForChild("RE/RegisterAttack")
local RegisterHit = Net:WaitForChild("RE/RegisterHit")
function UseNormalClick(Character, Cooldown)
	local RootPart, BladeHits = GetAllBladeHits(Character)
	RE_RegisterAttack:FireServer(Cooldown)

	if SUCCESS_FLAGS and COMBAT_REMOTE_THREAD and SUCCESS_HIT and HIT_FUNCTION then
		HIT_FUNCTION(RootPart, BladeHits)
	else
		RE_RegisterHit:FireServer(RootPart, BladeHits)
	end
end

local v36 = {};
local v37 = 0;
local _ = Random.new();
local v39 = nil;
local v40 = nil;
local v41 = nil;
local v42 = nil;
local v43 = nil;
local v44 = nil;
local v45 = nil;
local v46 = nil;

spawn(function()
	while wait() do
		if getgenv().Enabled then
			UseNormalClick(game.Players.LocalPlayer.Character, 0.3)
		end
	end
end)
spawn(function()
	while wait() do
		if getgenv().Enabled2 then
			UseNormalClick(game.Players.LocalPlayer.Character, 0.3)
			wait(math.random(5, 10))
		end
	end
end)

function EnableBuso()
	if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
		local args = {
			[1] = "Buso"
		}
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
	end
end

function GetWeapon(bh)
	s = ""
	for r, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") and v.ToolTip == bh then
			s = v.Name
		end
	end
	for r, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") and v.ToolTip == bh then
			s = v.Name
		end
	end
	return s
end

function EquipWeapon(ToolSe)
	if ToolSe == "" or ToolSe == nil then
		ToolSe = "Melee"
	end
	if game.Players.LocalPlayer.Backpack:FindFirstChild(GetWeapon(ToolSe)) then
		local bi = game.Players.LocalPlayer.Backpack:FindFirstChild(GetWeapon(ToolSe))
		wait(.4)
		game.Players.LocalPlayer.Character.Humanoid:EquipTool(bi)
	end
end

local Tweento = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/ZhxCKaMPVfef/huhu/refs/heads/master/tween.lua"))()
function equipweapon(aq)
	local c6 = tostring(aq)
	local c7 = game.Players.LocalPlayer.Backpack:FindFirstChild(c6)
	local c8 =
		game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") or
		game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
	if c7 then
		c8:EquipTool(c7)
	end
end

function haveDarkbeard()
	for i, v in game:GetService("ReplicatedStorage"):GetChildren() do
		if string.find(v.Name, "Darkbeard") then
			return v
		end
	end
	for i, v in workspace.Enemies:GetChildren() do
		if string.find(v.Name, "Darkbeard") then
			return v
		end
	end
	return false
end

function isnight()
	return math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5
end

function getfm()
	if game:GetService("Lighting"):GetAttribute("MoonPhase") == 5 and (math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5) then
		return " | Full Moon"
	elseif game:GetService("Lighting"):GetAttribute("MoonPhase") == 4 then
		return " | Next Night"
	else
		return " | Bad Moon"
	end
end

function checkfm()
	if game:GetService("Lighting"):GetAttribute("MoonPhase") == 5 and (math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5) then
		return true
	end
end

function getmirage()
	if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
		return " | Yes"
	else
		return " | No"
	end
end

function checkgatcan()
	local a = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(
		"CheckTempleDoor")
	if a then
		return " | Pulled"
	else
		return " | No"
	end
end

function data()
	return math.floor(game
			.Lighting.ClockTime) ..
		" | " ..
		game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers .. getfm() .. getmirage() .. checkgatcan()
end

function getdarkfrag()
	for i, v in next, game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory") do
		if v.Name == "Dark Fragment" then
			return v.Count
		end
	end
	return 0
end

function getVampireFang()
	for i, v in next, game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory") do
		if v.Name == "Vampire Fang" then
			return v.Count
		end
	end
	return 0
end

function islive()
	return plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and
		plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0
end

local mobkata2 = {
    "Vampire",
    "Demonic"
}
local mobkata = {
    "Vampire [Lv. 975]",
    "Demonic [Lv. 2450]"
}
function CheckMob(a)
	for i, v in pairs(game.workspace.Enemies:GetChildren()) do
		if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
			if string.find(v.Name, a) and v.Humanoid.Health > 0 and plr.Character.Humanoid.Health > 0 then
				return v
			end
		end
	end
	return false
end

local BringMobChoosen
local LockCFrame

function GetNearestPlayer()
	ner = math.huge
	for r, v in pairs(workspace.Characters:GetChildren()) do
		if v.Name ~= plr.Name and v:FindFirstChild("HumanoidRootPart") and plr:DistanceFromCharacter(v.HumanoidRootPart.Position) <= 100 then
			return true
		end
	end
end

function SizePart(v)
	if not v:FindFirstChild("HumanoidRootPart") then
		return nil
	end
	v.HumanoidRootPart.CanCollide = false
	if not v.HumanoidRootPart:FindFirstChild("vando") then
		local aF = Instance.new("BodyVelocity")
		aF.Parent = v
		aF.Name = "vando"
		aF.MaxForce = Vector3.new(100000, 100000, 100000)
		aF.Velocity = Vector3.new(0, 0, 0)
	end
end

function BringMob()
	if not BringMobChoosen then
		repeat
			task.wait()
		until BringMobChoosen
	end
	sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
	if LockCFrame then
		for r, v in pairs(game.Workspace.Enemies:GetChildren()) do
			if
				(LockCFrame.Position - v.HumanoidRootPart.Position).Magnitude < 350 and
				(LockCFrame.Position - v.HumanoidRootPart.Position).Magnitude > 3 and v.Name == BringMobChoosen.Name
			then
				v.HumanoidRootPart.CFrame = LockCFrame
				SizePart(v)
				for al, ax in pairs(v:GetDescendants()) do
					if ax:IsA("BasePart") or ax:IsA("Part") then
						ax.CanCollide = false
					end
				end
			end
		end
	end
	if BringMobChoosen then
		for r, v in pairs(game.Workspace.Enemies:GetChildren()) do
			if
				(BringMobChoosen.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 350 and
				(BringMobChoosen.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude > 3 and v:FindFirstChild("HumanoidRootPart") and v.Name == BringMobChoosen.Name
			then
				v.HumanoidRootPart.CFrame = BringMobChoosen.HumanoidRootPart.CFrame
				SizePart(v)
				for al, ax in pairs(v:GetDescendants()) do
					if ax:IsA("BasePart") or ax:IsA("Part") then
						ax.CanCollide = false
					end
				end
			end
		end
	end
end

function checkdevilfruit()
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if string.find(v.Name, "Fruit") then
			return v.Name
		end
	end
	return false
end

local plr = game.Players.LocalPlayer
local function AutoRaids(name)
	pcall(function()
		if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and not plr.PlayerGui.Notifications:FindFirstChild("NotificationTemplate") and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			ContentSet("Waiting No One In Raiding", data())
		end
		if not game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and plr.Data.Level.Value >= 1100 and not plr.PlayerGui.Notifications:FindFirstChild("NotificationTemplate") and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible and not plr.Backpack:FindFirstChild("Special Microchip") then
			--  Tweento(CFrame.new(-5013.625, 313.8533630371094, -2815.0322265625))
			if not checkdevilfruit() then
				if name == "Dough" then
					for i, v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")) do
						if v.Rarity == 3 and v.Type == "Blox Fruit" and not checkdevilfruit() then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", v.Name)
						end
					end
				else
					for i, v in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")) do
						if v.Rarity < 3 and v.Type == "Blox Fruit" and not checkdevilfruit() then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", v.Name)
						end
					end
				end
			end
			wait()
			if not checkdevilfruit() then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Cousin", "Buy")
			end
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", name)
		end
		if plr.Backpack:FindFirstChild("Special Microchip") and not game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			canceltween()
			if game.PlaceId == 7449423635 then
				canceltween()
				fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main
					.ClickDetector)
				oldfrag = game:GetService("Players").localPlayer.Data.Fragments.Value
			end
			if game.PlaceId == 4442272183 then
				fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main
					.ClickDetector)
				oldfrag = game:GetService("Players").localPlayer.Data.Fragments.Value
			end
			wait(0.5)
		end
		local dontkillaura = false
		if game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible then
			if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
				ContentSet("Island 5", data())
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10000 and v.Humanoid.Health > 0 then
						LockCFrame = v.HumanoidRootPart.CFrame
						BringMobChoosen = v
						repeat
							wait()
							pcall(function()
								spawn(function()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									end
								end)
								spawn(function()
									EquipWeapon()
								end)
								spawn(function()
									--   BringMob()
								end)
								spawn(function()
									EnableBuso()
								end)
								spawn(function()
									getgenv().Enabled = true
								end)
							end)
						until not v.Parent or v.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Timer.Visible or not dontkillaura
						getgenv().Enabled = false
					end
				end
				Tweento(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame *
					CFrame.new(0, 80, 0))
			elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
				ContentSet("Island 4", data())
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10000 and v.Humanoid.Health > 0 then
						LockCFrame = v.HumanoidRootPart.CFrame
						BringMobChoosen = v
						repeat
							wait()
							pcall(function()
								spawn(function()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									end
								end)
								spawn(function()
									EquipWeapon()
								end)
								spawn(function()
									--     BringMob()
								end)
								spawn(function()
									EnableBuso()
								end)
								spawn(function()
									getgenv().Enabled = true
								end)
							end)
						until not v.Parent or v.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Timer.Visible or not dontkillaura
						getgenv().Enabled = false
					end
				end
				Tweento(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame *
					CFrame.new(0, 80, 0))
			elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
				ContentSet("Island 3", data())
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10000 and v.Humanoid.Health > 0 then
						LockCFrame = v.HumanoidRootPart.CFrame
						BringMobChoosen = v
						repeat
							wait()
							pcall(function()
								spawn(function()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									end
								end)
								spawn(function()
									EquipWeapon()
								end)
								spawn(function()
									--     BringMob()
								end)
								spawn(function()
									EnableBuso()
								end)
								spawn(function()
									getgenv().Enabled = true
								end)
							end)
						until not v.Parent or v.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Timer.Visible or not dontkillaura
						getgenv().Enabled = false
					end
				end
				Tweento(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame *
					CFrame.new(0, 80, 0))
			elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
				ContentSet("Island 2", data())
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10000 and v.Humanoid.Health > 0 then
						LockCFrame = v.HumanoidRootPart.CFrame
						BringMobChoosen = v
						repeat
							wait()
							pcall(function()
								spawn(function()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									end
								end)
								spawn(function()
									EquipWeapon()
								end)
								spawn(function()
									--         BringMob()
								end)
								spawn(function()
									EnableBuso()
								end)
								spawn(function()
									getgenv().Enabled = true
								end)
							end)
						until not v.Parent or v.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Timer.Visible or not dontkillaura
						getgenv().Enabled = false
					end
				end
				Tweento(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame *
					CFrame.new(0, 80, 0))
			elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
				for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 10000 and v.Humanoid.Health > 0 then
						--Tweento(v.PrimaryPart.CFrame * CFrame.new(0, 20, 0))
						LockCFrame = v.HumanoidRootPart.CFrame
						BringMobChoosen = v
						repeat
							wait()
							pcall(function()
								spawn(function()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									end
								end)
								spawn(function()
									EquipWeapon()
								end)
								spawn(function()
									--  BringMob()
								end)
								spawn(function()
									EnableBuso()
								end)
								spawn(function()
									getgenv().Enabled = true
								end)
							end)
						until not v.Parent or v.Humanoid.Health <= 0 or not plr.PlayerGui.Main.Timer.Visible or not dontkillaura
						getgenv().Enabled = false
					end
				end
			end
		end
	end)
end
local farmnoboss = false
spawn(function()
	pcall(function()
		while wait() do
			pcall(function()
				if farmnoboss then
					local savemob1 = {}
					for i, v in workspace._WorldOrigin.EnemySpawns:GetChildren() do
						if table.find(mobkata, v.Name) and not table.find(savemob1, v.Name) and v:GetAttribute("Active") then
							ContentSet(
								"Waiting Mob Spawn ( " .. v.Name .. ' ) [ Vampire Fang: ' .. getVampireFang() .. " ] ",
								data())
							table.insert(savemob1, v.Name)

							Tweento(v.CFrame * CFrame.new(0, 20, 0))
						end
					end
					for i, v in workspace.Enemies:GetChildren() do
						if table.find(mobkata2, v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and CheckMob(v.Name) then
							ContentSet("Kill Mob ( " .. v.Name .. ' ) [ Vampire Fang: ' .. getVampireFang() .. " ] ",
								data())
							Tweento(v.PrimaryPart.CFrame * CFrame.new(0, 20, 0))
							LockCFrame = v.HumanoidRootPart.CFrame
							BringMobChoosen = v
							local old = tick()
							repeat
								wait()
								pcall(function()
									spawn(function()
										if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
											Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
										end
									end)
									spawn(function()
										EquipWeapon()
									end)
									spawn(function()
										BringMob()
									end)
									spawn(function()
										EnableBuso()
									end)
									spawn(function()
										getgenv().Enabled = true
									end)
								end)
							until not v or not v.Parent or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 or not v.PrimaryPart or not farmnoboss or not islive() or tick() - old >= 30 or not CheckMob(v.Name) or getVampireFang() >= 20
							getgenv().Enabled = false
							if tick() - old >= 30 then v:Destroy() end
						end
					end
				end
			end)
		end
	end)
end)
function havemelee()
	local v313 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt", true);
	if typeof(v313) == "string" then
		return false
	else
		return game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt", true)
	end
end

function writefileyummy()
	writefile(game.Players.LocalPlayer.Name .. ".txt", "Completed-Done")
end

function getDemonicFang()
    for i, v in next, game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory") do
        if v.Name == "Demonic Fang" then
            return v.Count
        end
    end
    return 0
end

function TeleportToSea3()
    -- Sea 3 PlaceId là 7449423635
    if game.PlaceId ~= 7449423635 then
        local args = {
            [1] = "TravelZou"
        }
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
        repeat wait(2) until game.PlaceId == 7449423635
    end
end

spawn(function()
    pcall(function()
        while wait() do
            pcall(function()
                if farmnoboss then
                    local savemob1 = {}
                    for i, v in workspace._WorldOrigin.EnemySpawns:GetChildren() do
                        if table.find(mobkata, v.Name) and not table.find(savemob1, v.Name) and v:GetAttribute("Active") then
                            local fangText = ""
                            if v.Name == "Demonic [Lv. 2450]" then
                                fangText = ' [ Demonic Fang: ' .. getDemonicFang() .. " ] "
                            else
                                fangText = ' [ Vampire Fang: ' .. getVampireFang() .. " ] "
                            end
                            ContentSet("Waiting Mob Spawn ( " .. v.Name .. fangText, data())
                            table.insert(savemob1, v.Name)
                            Tweento(v.CFrame * CFrame.new(0, 20, 0))
                        end
                    end
                    for i, v in workspace.Enemies:GetChildren() do
                        if table.find(mobkata2, v.Name) and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and CheckMob(v.Name) then
                            -- Nếu là Demonic thì tự động tele về Sea 3
                            if v.Name == "Demonic" or v.Name == "Demonic [Lv. 2450]" then
                                TeleportToSea3()
                            end
                            local fangText = ""
                            if v.Name == "Demonic" or v.Name == "Demonic [Lv. 2450]" then
                                fangText = ' [ Demonic Fang: ' .. getDemonicFang() .. " ] "
                            else
                                fangText = ' [ Vampire Fang: ' .. getVampireFang() .. " ] "
                            end
                            ContentSet("Kill Mob ( " .. v.Name .. fangText, data())
                            Tweento(v.PrimaryPart.CFrame * CFrame.new(0, 20, 0))
                            LockCFrame = v.HumanoidRootPart.CFrame
                            BringMobChoosen = v
                            local old = tick()
                            repeat
                                wait()
                                pcall(function()
                                    spawn(function()
                                        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                            Tweento(v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                                        end
                                    end)
                                    spawn(function()
                                        EquipWeapon()
                                    end)
                                    spawn(function()
                                        BringMob()
                                    end)
                                    spawn(function()
                                        EnableBuso()
                                    end)
                                    spawn(function()
                                        getgenv().Enabled = true
                                    end)
                                end)
                            until not v or not v.Parent or not v:FindFirstChild("Humanoid") or not v:FindFirstChild("HumanoidRootPart") or v.Humanoid.Health <= 0 or not v.PrimaryPart or not farmnoboss or not islive()
                            getgenv().Enabled = false
                            if tick() - old >= 30 then v:Destroy() end
                        end
                    end
                end
            end)
        end
    end)
end)
