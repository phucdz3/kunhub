_G.Kaitun = true
_G.Config = true
_G.Setting = {
    Main = {
        ["Auto Farm Level"] = true,
        ["StoreFruit"] = true,
        ["BuyFruit"] = true,
        ["SelectFruit"] = {
            "Lepoard-Lepoard",
			"Ice-Ice",
			"Linght-Linght"
        },
        --[[
			Kilo-Kilo
			Spin-Spin
			Chop-Chop
			Spring-Spring
			Bomb-Bomb
			Smoke-Smoke
			Spike-Spike
			Flame-Flame
			Falcon-Falcon
			Ice-Ice
			Sand-Sand
			Dark-Dark
			Revive-Revive
			Diamond-Diamond
			Linght-Linght
			Rubber-Rubber
			Barber-Barber
			Magma-Magma
			Quake-Quake
			Buddha-Buddha
			Love-Love
			Spider-Spider
			Phoenix-Phoenix
			Portal-Portal
			Rumble-Rumble
			Paw-Paw
			Blizzard-Blizzard
			Gravity-Gravity
			Dough-Dough
			Shadow-Shadow
			Venom-Venom
			Control-Control
			Spirit-Spirit
			Dragon-Dragon
			Leopard-Leopard
		]]
-----------// Setting \\-----------
        ["Auto Buso"] = true,
        ["Fast Attack"] = true,
------------// Sea 1 \\---------------
        ["Auto Saber"] = true,
        ["Auto Pole"] = true,
        ["AutoSecondSea"] = true,
------------// Sea 2 \\---------------
        ["Auto Bartilo Quest"] = true,
        ["Auto Rengoku"] = true,
        ["Auto Flamingo Access"] = true,
        ["Auto Factory Farm"] = true,
        ["Auto Super Human"] = true,
        ["Midnight Blade"] = true,
------------// Sea 3 \\---------------
        ["Auto Farm Mastery Sword All"] = true,
        ["Auto Soul Guitar"] = true,
        ["Auto ElectricClaw"] = true,
        ["Auto Yama"] = true,
        ["Auto Tushita"] = true,
    },
}

local Level_Max = 26000
--------------------------------// Sea \\----------------------------
local placeId = game.PlaceId
if game.PlaceId == 2753915549 then
	W1 = true
elseif game.PlaceId == 4442272183 then
	W2 = true
elseif game.PlaceId == 7449423635 then
	W3 = true
end

if game:IsLoaded() then
	pcall(function()
		repeat wait()
			game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy()
			game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy()
		until not game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") or not game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn")
	end)
	end
	
	function UnEquipWeapon(Weapon)
	if game.Players.LocalPlayer.Character:FindFirstChild(Weapon) then
		_G.NotAutoEquip = true
		task.wait(.5)
		game.Players.LocalPlayer.Character:FindFirstChild(Weapon).Parent = game.Players.LocalPlayer.Backpack
		task.wait(.1)
		_G.NotAutoEquip = false
	end
	end

--// Check Quest
local function QuestCheck()
	local Lvl = game:GetService("Players").LocalPlayer.Data.Level.Value
	if Lvl >= 1 and Lvl <= 9 then
		if tostring(game.Players.LocalPlayer.Team) == "Marines" then
			MobName = "Trainee [Lv. 5]"
			QuestName = "MarineQuest"
			QuestLevel = 1
			Mon = "Trainee"
			NPCPosition = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
		elseif tostring(game.Players.LocalPlayer.Team) == "Pirates" then
			MobName = "Bandit [Lv. 5]"
			Mon = "Bandit"
			QuestName = "BanditQuest1"
			QuestLevel = 1
			NPCPosition = CFrame.new(1058.60962, 16.428524, 1548.02307, -0.940542698, 2.14076756e-09, 0.339675426, 4.03729272e-09, 1, 4.87665197e-09, -0.339675426, 5.95806871e-09, -0.940542698)
		end
		return {
			[1] = QuestLevel,
			[2] = NPCPosition,
			[3] = MobName,
			[4] = QuestName,
			[5] = LevelRequire,
			[6] = Mon,
			[7] = MobCFrame
		}
	end
	
	if Lvl >= 210 and Lvl <= 249 then
		MobName = "Dangerous Prisoner [Lv. 210]"
		QuestName = "PrisonerQuest"
		QuestLevel = 2
		Mon = "Dangerous Prisoner"
		NPCPosition = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
		local matchingCFrames = {}
		local result = string.gsub(MobName, "Lv. ", "")
		local result2 = string.gsub(result, "[%[%]]", "")
		local result3 = string.gsub(result2, "%d+", "")
		local result4 = string.gsub(result3, "%s+", "")
		
		for i,v in pairs(game.workspace.EnemySpawns:GetChildren()) do
			if v.Name == result4 then
				table.insert(matchingCFrames, v.CFrame)
			end
			MobCFrame = matchingCFrames
		end
		return {
			[1] = QuestLevel,
			[2] = NPCPosition,
			[3] = MobName,
			[4] = QuestName,
			[5] = LevelRequire,
			[6] = Mon,
			[7] = MobCFrame
		}
	end
	
	--game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
	local GuideModule = require(game:GetService("ReplicatedStorage").GuideModule)
	local Quests = require(game:GetService("ReplicatedStorage").Quests)
	for i,v in pairs(GuideModule["Data"]["NPCList"]) do
		for i1,v1 in pairs(v["Levels"]) do
			if Lvl >= v1 then
				if not LevelRequire then
					LevelRequire = 0
				end
				if v1 > LevelRequire then
					NPCPosition = i["CFrame"]
					QuestLevel = i1
					LevelRequire = v1
				end
				if #v["Levels"] == 3 and QuestLevel == 3 then
					NPCPosition = i["CFrame"]
					QuestLevel = 2
					LevelRequire = v["Levels"][2]
				end
			end
		end
	end
	if Lvl >= 375 and Lvl <= 399 then -- Fishman Warrior
		MobCFrame = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
		if _G.StartFarm and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			return
		end
	end
	
	if Lvl >= 400 and Lvl <= 449 then -- Fishman Commando
		MobCFrame = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
		if _G.StartFarm and (MobCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			return
		end
	end
	for i,v in pairs(Quests) do
		for i1,v1 in pairs(v) do
			if v1["LevelReq"] == LevelRequire and i ~= "CitizenQuest" then
				QuestName = i
				for i2,v2 in pairs(v1["Task"]) do
					MobName = i2
					Mon = string.split(i2," [Lv. ".. v1["LevelReq"] .. "]")[1]
				end
			end
		end
	end
	if QuestName == "MarineQuest2" then
		QuestName = "MarineQuest2"
		QuestLevel = 1
		MobName = "Chief Petty Officer [Lv. 120]"
		Mon = "Chief Petty Officer"
		LevelRequire = 120
	elseif QuestName == "ImpelQuest" then
		QuestName = "PrisonerQuest"
		QuestLevel = 2
		MobName = "Dangerous Prisoner [Lv. 190]"
		Mon = "Dangerous Prisoner"
		LevelRequire = 210
		NPCPosition = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
	elseif QuestName == "SkyExp1Quest" then
		if QuestLevel == 1 then
			NPCPosition = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
		elseif QuestLevel == 2 then
			NPCPosition = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
		end
	elseif QuestName == "Area2Quest" and QuestLevel == 2 then
		QuestName = "Area2Quest"
		QuestLevel = 1
		MobName = "Swan Pirate [Lv. 775]"
		Mon = "Swan Pirate"
		LevelRequire = 775
	end
	MobName = MobName:sub(1,#MobName)
	if not MobName:find("Lv") then
		for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
			MonLV = string.match(v.Name, "%d+")
			if v.Name:find(MobName) and #v.Name > #MobName and tonumber(MonLV) <= Lvl + 50 then
				MobName = v.Name
			end
		end
	end
	if not MobName:find("Lv") then
		for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
			MonLV = string.match(v.Name, "%d+")
			if v.Name:find(MobName) and #v.Name > #MobName and tonumber(MonLV) <= Lvl + 50 then
				MobName = v.Name
				Mon = a
			end
		end
	end
	
	local matchingCFrames = {}
	local result = string.gsub(MobName, "Lv. ", "")
	local result2 = string.gsub(result, "[%[%]]", "")
	local result3 = string.gsub(result2, "%d+", "")
	local result4 = string.gsub(result3, "%s+", "")
	
	for i,v in pairs(game.workspace.EnemySpawns:GetChildren()) do
		if v.Name == result4 then
			table.insert(matchingCFrames, v.CFrame)
		end
		MobCFrame = matchingCFrames
	end
	
	return {
		[1] = QuestLevel,
		[2] = NPCPosition,
		[3] = MobName,
		[4] = QuestName,
		[5] = LevelRequire,
		[6] = Mon,
		[7] = MobCFrame,
		[8] = MonQ,
		[9] = MobCFrameNuber
	}
	end
	
	
-- // Tween \\ --

function toposition(Point)
	TweeSpeed = 275
	local LocalPlayer = game.Players.LocalPlayer 
	TweenPlay = (Point.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	pcall(function() 
			tot = game:GetService("TweenService"):Create(LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(TweenPlay/TweeSpeed, Enum.EasingStyle.Linear),{CFrame = Point})
	end);tot:Play()
	
	if TweenPlay <= 200 then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
	end
	
	if LocalPlayer.Character.Humanoid.Sit == true then 
		LocalPlayer.Character.Humanoid.Sit = false 
	end
	
	if _G.StopTween == true then tot:Cancel();_G.Clip = false end
	if _G.StopTween then
		tot:Cancel()
		BringMobFarm = false
		UseSkillGun = false
		UseSkill = false
	elseif game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
		tot:Play()
	elseif game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
		tot:Cancel()
		BringMobFarm = false
		UseSkillGun = false
		UseSkill = false
		wait(0.5)
	end
	end	
	
	function StopTween(target)
	if not target then
		_G.StopTween = true
		_G.StertScript = false
		task.wait()
			toposition(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
		task.wait()
		BringMobFarm = false
		UseSkillGun = false
		UseSkill = false
		toposition(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
		_G.StopTween = false
		_G.StertScript = false
		_G.Clip = false
		if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
		end
	end
	end
	
	function TPPlayer(Point)
	TweeSpeed = 300
	local LocalPlayer = game.Players.LocalPlayer 
	TweenPlay = (Point.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	local Dis = (Point.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	pcall(function() 
			tot = game:GetService("TweenService"):Create(LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(TweenPlay/TweeSpeed, Enum.EasingStyle.Linear),{CFrame = Point})
	end);tot:Play()
	if TweenPlay >= 1200 then
		_G.StopTween = true
		game.Players.LocalPlayer.Character.Head:Destroy()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(0,50,0)
		wait(.2)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		wait(.1)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(0,50,0)
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
		wait(.1)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		wait(0.5)
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
		_G.Clip = false
		_G.StopTween = false
	elseif TweenPlay <= 300 then
		tot:Cancel()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		wait(0.2)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point*CFrame.new(0,30,0)
	end
	
	if Dis <= 350 then
		tot:Cancel()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		wait(0.2)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point*CFrame.new(0,30,0)
	end
	
	if _G.StopTween == true then tot:Cancel();_G.Clip = false end
		if _G.StopTween then
			tot:Cancel()
			BringMobFarm = false
			UseSkillGun = false
			UseSkill = false
		elseif game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
			tot:Play()
		elseif game.Players.LocalPlayer.Character.Humanoid.Health <= 0 then
			tot:Cancel()
			BringMobFarm = false
			UseSkillGun = false
			UseSkill = false
		end
	end	
	
	getgenv().TP = function(Pos)
		Distance = (Pos.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
		if Distance < 250 then
			Speed = 225
		elseif Distance >= 1000 then
			Speed = 150
		end
		game:GetService("TweenService"):Create(
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
			TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
			{CFrame = Pos}
		):Play()
		_G.Clip = true
		wait(Distance/Speed)
		_G.Clip = false
		return
	end
	
	-- // Bypass \\ --
	
	function Bypass(Point)
		toposition(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
		wait(1.5)
		_G.StopTween = true
		_G.StertScript = false
	
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
		game.Players.LocalPlayer.Character.Head:Destroy()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(0,50,0)
		wait(.2)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		wait(.1)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(0,50,0)
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
		wait(.1)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point
		wait(0.5)
		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Point * CFrame.new(900,900,900)
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
	
		_G.StopTween = false
		_G.StertScript = false
		_G.Clip = false
		if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
		end
		_G.Clip = false
	end
	
	-- // Check Sword \\ --
	
	function Check_Sword(Sword_Name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Remotes['CommF_']:InvokeServer("getInventory")) do
			if (v.Type == "Sword") then
				if v.Name == Sword_Name then
					return true
				end
			end
		end
	end
	
	--Soul Guitar
	function Check_Gun(Gun_Name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Remotes['CommF_']:InvokeServer("getInventory")) do
			if (v.Type == "Gun") then
				if v.Name == Gun_Name then
					return true
				end
			end
		end
	end
	
	local function Check_Material(Material_Name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Remotes['CommF_']:InvokeServer("getInventory")) do
			if v.Type == "Material" then
				if v.Name == Material_Name then
					return v.Count
				end
			end
		end
		return 0
	end
	
	---------------------
	
	spawn(function()
	game:GetService("RunService").Stepped:Connect(function()
		if _G.Start_Kaitun then
			for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false    
				end
			end
			game:GetService'VirtualUser':CaptureController()
			game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
		end
	end)
	end)
	
	spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Start_Kaitun then
				if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local Noclip = Instance.new("BodyVelocity")
					Noclip.Name = "BodyClip"
					Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
					Noclip.MaxForce = Vector3.new(100000,100000,100000)
					Noclip.Velocity = Vector3.new(0,0,0)
				end
			else
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
			end
		end)
	end
	end)

-----------------------------------------------------------------------------------------------------------------------------------------------
	
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
	Name = "thuhien kaitun", 
	HidePremium = false,
	IntroText = "thuhien kaitun", 
	SaveConfig = true, 
	ConfigFolder = "nhuttruong"
})

local G = Window:MakeTab({
	Name = "General",
	Icon = "rbxassetid://16172859554",
	PremiumOnly = false
})

    

Code = {
	"EXP_5B",
	"CONTROL",
	"UPDATE11",
	"XMASEXP",
	"1BILLION",
	"ShutDownFix2",
	"UPD14",
	"STRAWHATMAINE",
	"TantaiGaming",
	"Colosseum",
	"Axiore",
	"Sub2Daigrock",
	"Sky Island 3",
	"Sub2OfficialNoobie",
	"SUB2NOOBMASTER123",
	"THEGREATACE",
	"Fountain City",
	"BIGNEWS",
	"FUDD10",
	"SUB2GAMERROBOT_EXP1",
	"UPD15",
	"2BILLION",
	"UPD16",
	"3BVISITS",
	"fudd10_v2",
	"Starcodeheo",
	"Magicbus",
	"JCWK",
	"Bluxxy",
	"Sub2Fer999",
	"Enyu_is_Pro"
}

G:AddToggle({
	Name = "Kaitun",
	Default = false,
	Callback = function(Value)
		_G.Start_Kaitun = Value
	end
})

if _G.Config == false then
	_G.Start_Saber = value
	_G.StartFarm = value
	_G.Start_Pole = value
	_G.Auto_New_World = value
	_G.Auto_Bartilo_Quest = value
	_G.AutoRengoku = value
	_G.Grab_Fruit = value 
	_G.StoreFruit = value
	_G.AutoFarmBossAll = value
	_G.Open_Flamingo_Access = value
	_G.Midnight_Blade = value
	_G.Auto_Factory_Farm = value
	_G.Start_GoTo_Thire_World = value
	_G.Auto_Yama = value
	_G.Auto_Tushita = value
	_G.Auto_Superhuman = value
	_G.Auto_Electric_Claw = value
	_G.Auto_Farm_Mastery_Sword = value
	_G.Auto_Buy_Devil_Fruit = value
	_G.Auto_Soul_Guitar = value
end
if value == true then
	if _G.Settings.Main["Auto Farm"] and _G.Auto_Dungeon_Superhuman == nil  then
		_G.StartFarm = value
	end
	if _G.Settings.Main["Auto Saber"] then
		_G.Start_Saber = true
	end
	if _G.Settings.Main["Auto Pole"] then
		_G.Start_Pole = true
	end
	if _G.Settings.Main["Auto New World"] then
		_G.Auto_New_World = true
	end
	if _G.Settings.Main["Auto Bartilo Quest"] then
		_G.Auto_Bartilo_Quest = true
	end
	if _G.Settings.Main["Auto Rengoku"] then
		_G.AutoRengoku = true
	end
	if _G.Settings.Main["Auto Go To Fruit"] then
		_G.Grab_Fruit = true
	end
	if _G.Settings.Main["Store Fruit"] then
		_G.StoreFruit = true
	end
	if _G.Settings.Main["Open Flamingo Access"] then
		_G.Open_Flamingo_Access = true
	end
	if _G.Settings.Main["Midnight Blade"] then
		_G.Midnight_Blade = true
	end
	if _G.Settings.Main["Auto Factory Farm"] then
		_G.Auto_Factory_Farm = true
	end
	if _G.Settings.Main["Thire World"] then
		_G.Start_GoTo_Thire_World = true
	end
	if _G.Settings.Main["Auto Tushita"] then
		_G.Auto_Tushita = true
	end
	if _G.Settings.Main["Auto Yama"] then
		_G.Auto_Yama = true
	end
	if _G.Settings.Main["Auto ElectricClaw"] then
		_G.Auto_Electric_Claw = true
	end
	if _G.Settings.Main["Auto Super Human"] then
		_G.Auto_Superhuman = true
	end
	if _G.Settings.Main["Auto Farm Mastery Sword All"] then
		_G.Auto_Farm_Mastery_Sword = true
	end
	if _G.Settings.Main["Buy Fruit"] then
		_G.Auto_Buy_Devil_Fruit = true
	end
	if _G.Settings.Main["Auto Soul Guitar"] then
		_G.Auto_Soul_Guitar = true
	end
end

if value == false then
	if _G.Settings.Main["Auto Farm"] then
		_G.StartFarm = false
	end
	if _G.Settings.Main["Auto Saber"] then
		_G.Start_Saber = false
	end
	if _G.Settings.Main["Auto Pole"] then
		_G.Start_Pole = false
	end
	if _G.Settings.Main["Auto New World"] then
		_G.Auto_New_World = false
	end
	if _G.Settings.Main["Auto Bartilo Quest"] then
		_G.Auto_Bartilo_Quest = false
	end
	if _G.Settings.Main["Auto Rengoku"] then
		_G.AutoRengoku = false
	end
	if _G.Settings.Main["Auto Go To Fruit"] then
		_G.Grab_Fruit = false
	end
	if _G.Settings.Main["Store Fruit"] then
		_G.StoreFruit = false
	end
	if _G.Settings.Main["Open Flamingo Access"] then
		_G.Open_Flamingo_Access = false
	end
	if _G.Settings.Main["Midnight Blade"] then
		_G.Midnight_Blade = false
	end
	if _G.Settings.Main["Auto Factory Farm"] then
		_G.Auto_Factory_Farm = false
	end
	if _G.Settings.Main["Thire World"] then
		_G.Start_GoTo_Thire_World = false
	end
	if _G.Settings.Main["Auto Tushita"] then
		_G.Auto_Tushita = false
	end
	if _G.Settings.Main["Auto Yama"] then
		_G.Auto_Yama = false
	end
	if _G.Settings.Main["Auto ElectricClaw"] then
		_G.Auto_Electric_Claw = false
	end
	if _G.Settings.Main["Auto Super Human"] then
		_G.Auto_Superhuman = false
	end
	if _G.Settings.Main["Auto Farm Mastery Sword All"] then
		_G.Auto_Farm_Mastery_Sword = false
	end	
	if _G.Settings.Main["Buy Fruit"] then
		_G.Auto_Buy_Devil_Fruit = false
	end
	if _G.Settings.Main["Auto Soul Guitar"] then
		_G.Auto_Soul_Guitar = false
	end
end

StopTween(_G.Start_Kaitun)


function EquipWeaponSword()
for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if v.ToolTip == "Sword" then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
			EquipWeapon(v.Name)
		end
	end
end
end

local SetCFarme = 1
local function GetIsLand(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = targetPos
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos.Position
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
		RealTarget = RealTarget.p
	end

	local ReturnValue
	local CheckInOut = math.huge;
	if game.Players.LocalPlayer.Team then
		for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do 
			local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
			if ReMagnitude < CheckInOut then
				CheckInOut = ReMagnitude;
				ReturnValue = v.Name
			end
		end
		if ReturnValue then
			return ReturnValue
		end 
	end
end
function GetCake_CFrame_Mon()
	local targetMonsters = {"Baking Staff [Lv. 2250]", "Head Baker [Lv. 2275]", "Cake Guard [Lv. 2225]", "Cookie Crafter [Lv. 2200]"}
	local enemySpawns = workspace.EnemySpawns:GetChildren()
	local randomSpawnIndex = math.random(1, #enemySpawns)
	local selectedSpawn = enemySpawns[randomSpawnIndex]
	
	for _,_v1 in pairs(targetMonsters) do
		local result = string.gsub(_v1, "Lv. ", "")
		local result2 = string.gsub(result, "[%[%]]", "")
		local result3 = string.gsub(result2, "%d+", "")
		local result4 = string.gsub(result3, "%s+", "")
		local monQName = result4
		
		if selectedSpawn.Name == result4 then
			return selectedSpawn.CFrame
		end
	end
end
function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then 
			return true
		end
		return false
	end
end
spawn(function()
	while true do wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.StartFarm and _G.Bring_Mob and BringMobFarm then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 500 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMon
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.Size = Vector3.new(60,60,60)
							v.HumanoidRootPart.Transparency = 1
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid:ChangeState(14)
							sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while wait() do
		local MyLevel = game.Players.LocalPlayer.Data.Level.Value
		local QuestC = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
		pcall(function()
			if _G.Start_Kaitun and _G.StartFarm then
				if _G.GoGat and (MyLevel >= 15 and MyLevel <= 300) then
					if MyLevel >= 15 and MyLevel <= 300 then
						Start_KaitunFast()
					end
				elseif MyLevel >= Level_Max then
					for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
						if type(v) == "table" then
							if v.Type == "Sword" then
								if tonumber(v.Mastery) >= 1 and tonumber(v.Mastery) < 600 then
									Name = v.Name
									Mastery = v.Mastery
									if tonumber(v.Mastery) >= 1 and tonumber(v.Mastery) < 600 then
										if game.Players.LocalPlayer.Backpack:FindFirstChild(Name) or game.Players.LocalPlayer.Character:FindFirstChild(Name) then
											if game.Workspace.Enemies:FindFirstChild("Baking Staff [Lv. 2250]") or game.Workspace.Enemies:FindFirstChild("Head Baker [Lv. 2275]") or game.Workspace.Enemies:FindFirstChild("Cake Guard [Lv. 2225]") or game.Workspace.Enemies:FindFirstChild("Cookie Crafter [Lv. 2200]")  then
												for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do  
													if (v.Name == "Baking Staff [Lv. 2250]" or v.Name == "Head Baker [Lv. 2275]" or v.Name == "Cake Guard [Lv. 2225]" or v.Name == "Cookie Crafter [Lv. 2200]") and v.Humanoid.Health > 0 then
														repeat wait()
															PosMon = v.HumanoidRootPart.CFrame
															EquipWeaponSword()
															v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
															BringMobFarm = true
															toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
														until _G.Start_Kaitun == false or not v.Parent or v.Humanoid.Health <= 0
													end
												end
											else
												BringMobFarm = false
												toposition(GetCake_CFrame_Mon() * CFrame.new(0, 30, 5))
												wait(0.5)
											end
										else
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem",Name)
										end
									elseif v.Mastery > 599 then
										if game.Players.LocalPlayer.Backpack:FindFirstChild(Name) or game.Players.LocalPlayer.Character:FindFirstChild(Name) then
										else
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem",Name)
										end
									end
									break
								end
							end
						end
					end
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
					if game.ReplicatedStorage:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or  game.ReplicatedStorage:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King [Lv. 2300] [Raid Boss]") then 
						if not game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
							for _,x in pairs(game.ReplicatedStorage:GetChildren()) do 
								if x.Name == "Cake Prince [Lv. 2300] [Raid Boss]" or x.Name == "Dough King [Lv. 2300] [Raid Boss]" then
									if (x.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
										wait(1.5)
										toposition(CFrame.new(-2145.89722, 70.0088272, -12399.6016, 0.99999702, 1.58276379e-08, 0.00245277886, -1.57982978e-08, 1, -1.19813057e-08, -0.00245277886, 1.19425199e-08, 0.99999702))
										return
									end
								end
							end
						end
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Cake Prince [Lv. 2300] [Raid Boss]" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat task.wait()
										if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
											toposition(CFrame.new(-2145.89722, 70.0088272, -12399.6016, 0.99999702, 1.58276379e-08, 0.00245277886, -1.57982978e-08, 1, -1.19813057e-08, -0.00245277886, 1.19425199e-08, 0.99999702))
											return
										end
										EquipWeapon(_G.Select_Weapon)
										v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
										BringMobFarm = true
										toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
										if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
										end
										sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
									until not _G.StartFarm or not v.Parent or v.Humanoid.Health <= 0
								end
							else
								for _,x in pairs(game.ReplicatedStorage:GetChildren()) do 
									if x.Name == "Cake Prince [Lv. 2300] [Raid Boss]" or x.Name == "Dough King [Lv. 2300] [Raid Boss]" then
										if (x.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1000 then
											toposition(CFrame.new(-2145.89722, 70.0088272, -12399.6016, 0.99999702, 1.58276379e-08, 0.00245277886, -1.57982978e-08, 1, -1.19813057e-08, -0.00245277886, 1.19425199e-08, 0.99999702))
											return
										end
									end
								end
							end
						end
					else
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if string.find(v.Name, "Boss") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000 then
								repeat task.wait()
									v.HumanoidRootPart.Size = Vector3.new(60,60,60)
									v.HumanoidRootPart.CanCollide = false
									v.Humanoid.WalkSpeed = 0
									v.Head.CanCollide = false
									BringMobFarm = true
									EquipWeapon(_G.Select_Weapon)
									v.HumanoidRootPart.Transparency = 1
									if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
										Bypass(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
										return
									end
									toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))

									if not _G.Start_Kaitun or not _G.Start_KaitunO or _G.Start_Kaitun or _G.Start_KaitunO then
										
										
									end
								until not _G.StartFarm or not v.Parent or v.Humanoid.Health <= 0 or not v:FindFirstChild("HumanoidRootPart")
							else
								if QuestC.Visible == true then
									if (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
										Bypass(QuestCheck()[2])
									end
									if game:GetService("Workspace").Enemies:FindFirstChild(QuestCheck()[3]) then
										for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
											if v.Name == QuestCheck()[3] then
												if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
													repeat task.wait()
														if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, QuestCheck()[6]) then
															game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
														else
															PosMon = v.HumanoidRootPart.CFrame
															v.HumanoidRootPart.Size = Vector3.new(60,60,60)
															v.HumanoidRootPart.CanCollide = false
															v.Humanoid.WalkSpeed = 0
															v.Head.CanCollide = false
															BringMobFarm = true
															EquipWeapon(_G.Select_Weapon)
															v.HumanoidRootPart.Transparency = 1
															toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
			
															if not _G.Start_Kaitun or not _G.Start_KaitunO or _G.Start_Kaitun or _G.Start_KaitunO then
																
																
															end
														end
													until not _G.StartFarm or not v.Parent or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
												end
											end
										end
									else
										UnEquipWeapon(_G.Select_Weapon)
										toposition(QuestCheck()[7][SetCFarme] * CFrame.new(0,30,5))
										if (QuestCheck()[7][SetCFarme].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
											if SetCFarme == nil or SetCFarme == '' then
												SetCFarme = 1
												print(SetCFarme)
											elseif SetCFarme >= #QuestCheck()[7] then
												SetCFarme = 1
												print(SetCFarme)
											end
											SetCFarme =  SetCFarme + 1
			
											print(SetCFarme)
											wait(0.5)
										end
									end
								else
									wait(0.5)
									if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == tostring(GetIsLand(QuestCheck()[7][1])) then
										game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", QuestCheck()[4], QuestCheck()[1]) wait(0.5)
										toposition(QuestCheck()[7][1] * CFrame.new(0,30,20))
									else
										if (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
											Bypass(QuestCheck()[2])
										else
											repeat wait() toposition(QuestCheck()[2]) until (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.StartFarm
										end
										repeat wait() toposition(QuestCheck()[2]) until (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.StartFarm
										if (QuestCheck()[2].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
											BringMobFarm = false
											wait(0.2)
											game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", QuestCheck()[4], QuestCheck()[1]) wait(0.5)
											toposition(QuestCheck()[7][1] * CFrame.new(0,30,20))
										end
									end
								end
							end
						end
					end
				end
			end
		end)
	end
end)
_G.ChackPlayer = 0
_G.ChackPlayer2 = _G.ChackPlayer
function Start_KaitunFast()
	local PlayersAll = game.Players:GetPlayers()
	local PlayerLevel = game.Players.LocalPlayer.Data.Level.Value
	local quest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
	local Player = string.split(quest," ")[2]
	getgenv().SelectPly = string.split(quest," ")[2]
	pcall(function()
		local MyLevel = game.Players.LocalPlayer.Data.Level.Value
		local QuestC = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
		CFrameMon = CFrame.new(-4837.64258, 850.10199, -1840.58374, -0.430530697, -4.42848638e-08, -0.90257591, -3.08042516e-08, 1, -3.43712756e-08, 0.90257591, 1.30052875e-08, -0.430530697)

		if MyLevel >= 15 and MyLevel <= 69 then
			BringMobFarm55 = false
			for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
				if v.Name == "God's Guard [Lv. 450]" then
					if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
						repeat task.wait()
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
							v.HumanoidRootPart.CanCollide = false
							v.Humanoid.WalkSpeed = 0
							v.Head.CanCollide = false
							BringMobFarm55 = true
							EquipWeapon(_G.Select_Weapon)
							PosMon = v.HumanoidRootPart.CFrame
							v.HumanoidRootPart.Size = Vector3.new(60,60,60)
							v.HumanoidRootPart.Transparency = 1
							toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
							if not _G.Start_Kaitun or not _G.Start_KaitunO or _G.Start_Kaitun or _G.Start_KaitunO or _G.SuperFastAttack then
								
								
							end
						until not v.Parent or not _G.Start_Kaitun or v.Humanoid.Health < 0
					end
				else
					BringMobFarm55 = false
					if _G.Start_Kaitun and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
					end
					toposition(CFrameMon)
				end
			end
		elseif MyLevel >= 70 and MyLevel <= 309 then
			if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
			end
			if QuestC.Visible == false then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
			elseif QuestC.Visible == true then
				if string.find(quest,"Defeat") then
					if game.Players[getgenv().SelectPly].Data.Level.Value >= 20 and game.Players[getgenv().SelectPly].Data.Level.Value <= MyLevel * 5 then
						repeat task.wait()
							if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
							end
							if game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
							end
							EquipWeapon(_G.Select_Weapon)
							
							TPPlayer(game:GetService("Players")[getgenv().SelectPly].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,5))
							
							game:GetService("Players")[getgenv().SelectPly].Character.HumanoidRootPart.Size = Vector3.new(120,120,120)

							game:service('VirtualInputManager'):SendKeyEvent(true, "X", false, game)
							game:service('VirtualInputManager'):SendKeyEvent(false, "X", false, game)

							game:service('VirtualInputManager'):SendKeyEvent(true, "Z", false, game)
							game:service('VirtualInputManager'):SendKeyEvent(false, "Z", false, game)

							if not _G.Start_Kaitun or not _G.Start_KaitunO or _G.Start_Kaitun or _G.Start_KaitunO or _G.SuperFastAttack then
								
								
							end
						until game.Players[getgenv().SelectPly].Character.Humanoid.Health <= 0 or not game.Players[getgenv().SelectPly].Character.Humanoid.Health or not Start_KaitunFast()
						_G.GoGat = false
						_G.KillPlayerQ = true
						if not game.Players:FindFirstChild(Player) then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
						end
					else
						for i,v in pairs(PlayersAll) do
							if v.Data.Level.Value >= 20 and v.Data.Level.Value <= PlayerLevel * 5 then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
								print(v)
							else
								_G.ChackPlayer = _G.ChackPlayer + 1
								if _G.ChackPlayer >= 12 then
									_G.GoGat = false
								else
									print("Chack Player ".._G.ChackPlayer)
								end
							end
						end
					end
				end
			end
		end
	end)
end

function Hop()
	local PlaceID = game.PlaceId
	local AllIDs = {}
	local foundAnything = ""
	local actualHour = os.date("!*t").hour
	local Deleted = false
	function TPReturner()
		local Site;
		if foundAnything == "" then
			Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
		else
			Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
		end
		local ID = ""
		if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
			foundAnything = Site.nextPageCursor
		end
		local num = 0;
		for i,v in pairs(Site.data) do
			local Possible = true
			ID = tostring(v.id)
			if tonumber(v.maxPlayers) > tonumber(v.playing) then
				for _,Existing in pairs(AllIDs) do
					if num ~= 0 then
						if ID == tostring(Existing) then
							Possible = false
						end
					else
						if tonumber(actualHour) ~= tonumber(Existing) then
							local delFile = pcall(function()
								AllIDs = {}
								table.insert(AllIDs, actualHour)
							end)
						end
					end
					num = num + 1
				end
				if Possible == true then
					table.insert(AllIDs, ID)
					task.wait()
					pcall(function()
						task.wait()
						game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
					end)
					task.wait(4)
				end
			end
		end
	end
	function Teleport() 
		while task.wait() do
			pcall(function()
				TPReturner()
				if foundAnything ~= "" then
					TPReturner()
				end
			end)
		end
	end
	Teleport()
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.Start_Kaitun and W2 and _G.Open_Flamingo_Access and _G._G.Start_Kaitun == nil and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil and game.Players.LocalPlayer.Data.Level.Value >= 1500 then
				FruitPrice = {}
				FruitStore = {}
				for i,v in next,game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
					if v.Price >= 1000000 then  
						table.insert(FruitPrice,v.Name)
					end
				end
				for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
					for _,x in pairs(v) do
						if _ == "Name" then 
							table.insert(FruitStore,x)
						end
					end
				end
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
				for _,y in pairs(FruitPrice) do
					for _,z in pairs(FruitStore) do
						if y == z and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
							_G.StartFarm = false
							_G.StoreFruit = false
							if not game.Players.LocalPlayer.Backpack:FindFirstChild(FruitStore) then
								local args = {
									[1] = "LoadFruit",
									[2] = tostring(y)
								}
					
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							else
								local args = {
									[1] = "TalkTrevor",
									[2] = "1"
								}
								
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								local args = {
									[1] = "TalkTrevor",
									[2] = "2"
								}
								
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								local args = {
									[1] = "TalkTrevor",
									[2] = "3"
								}
								
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
							end
						end
					end 
				end
				local args = {
					[1] = "TalkTrevor",
					[2] = "1"
				}
				
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				local args = {
					[1] = "TalkTrevor",
					[2] = "2"
				}
				
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				local args = {
					[1] = "TalkTrevor",
					[2] = "3"
				}
				
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				wait(0.1)
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
					_G.StoreFruit = true
					_G.Open_Flamingo_Access = false
				end
			end
		end)
	end
end)



spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.Start_Saber and game.Players.LocalPlayer.Data.Level.Value >= 200 and Check_Sword("Saber") == nil and W1 then
				_G.StartFarm = false
			end
		end)
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.Start_Saber and game.Players.LocalPlayer.Data.Level.Value >= 200 and Check_Sword("Saber") == nil and W1 then
				_G.StartFarm = false
				Level_SD:Set("Stats : Saber")
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
				if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then
					if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency == 0 then
						if (CFrame.new(-1480.06018, 47.9773636, 4.53454018, -0.386713833, 1.11673025e-07, 0.922199786, 7.96717785e-08, 1, -8.76847395e-08, -0.922199786, 3.95643944e-08, -0.386713833).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
							toposition(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
							task.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame
							task.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame
							task.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame
							task.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame
							task.wait(1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame
							task.wait(1) 
						end
					local CFrameSaber = CFrame.new(-1480.06018, 47.9773636, 4.53454018, -0.386713833, 1.11673025e-07, 0.922199786, 7.96717785e-08, 1, -8.76847395e-08, -0.922199786, 3.95643944e-08, -0.386713833)
					if _G.Start_Kaitun and _G.Start_Saber and (CFrameSaber.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1200 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
						toposition(CFrameSaber)
					end
					toposition(CFrameSaber)
				else
					if game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0 then
						if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
							EquipWeapon("Torch")
							toposition(CFrame.new(1113.7229, 5.04679585, 4350.33691, -0.541527212, 5.27007726e-09, 0.840683222, 8.74004868e-08, 1, 5.00303372e-08, -0.840683222, 1.00568911e-07, -0.541527212))
							UnEquipWeapon("Torch")
							EquipWeapon("Torch")
							task.wait(0.5)
						else
							toposition(CFrame.new(-1610.56824, 12.1773882, 162.830322, -0.907543361, -2.88120088e-08, -0.419958383, -4.66550922e-08, 1, 3.22163096e-08, 0.419958383, 4.88308949e-08, -0.907543361))                 
						end
					else
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
							task.wait(0.5)
							EquipWeapon("Cup")
							task.wait(0.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game:GetService("Players").LocalPlayer.Character.Cup)
							task.wait(0)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") 
						else
							if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
							elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
								if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
									for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
										if v.Name == "Mob Leader [Lv. 120] [Boss]" then
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat task.wait()
													EquipWeapon(_G.Select_Weapon)
													v.HumanoidRootPart.CanCollide = false
													v.Humanoid.WalkSpeed = 0
													v.Head.CanCollide = false
													v.HumanoidRootPart.Size = Vector3.new(100,100,100)
													v.HumanoidRootPart.Transparency = 1
													EquipWeapon(_G.Select_Weapon)
													toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,35,5))
													if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO or _G.SuperFastAttack then game:GetService'VirtualUser':CaptureController() game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672)) end
												until v.Humanoid.Health <= 0 or _G.AutoSaber == false
											end
										else
											for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do 
												if v.Name == "Mob Leader [Lv. 120] [Boss]" then
													toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,35,5))
												end
											end
										end
									end
								end
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
							task.wait(0.5)
							EquipWeapon("Relic")
							task.wait(0.5)
							toposition(CFrame.new(-1406.37512, 29.9773273, 4.45027685, 0.877344251, -3.82776442e-08, 0.479861468, 4.93218133e-09, 1, 7.07504668e-08, -0.479861468, -5.9705755e-08, 0.877344251))
						end
					end
				end
			end
				else
					if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Saber Expert [Lv. 200] [Boss]" then
								repeat task.wait()
									EquipWeapon(_G.Select_Weapon)
									v.HumanoidRootPart.Size = Vector3.new(60,60,60)
									v.HumanoidRootPart.Transparency = 1
									toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
									if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO or _G.SuperFastAttack then game:GetService'VirtualUser':CaptureController() game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672)) end
								until v.Humanoid.Health <= 0 or _G.AutoSaber == false
								_G.Start_Saber = false
								_G.StartFarm = true
								if v.Humanoid.Health <= 0 then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","PlaceRelic")
								end
							else
								toposition(game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert [Lv. 200] [Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,5))
							end
						end
					else 
						repeat task.wait()
							_G.Start_Saber = false
							_G.StartFarm = true
						until _G.Start_Saber == true or game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]")
						_G.Start_Saber = true
						_G.StartFarm = false
					end
				end
			elseif _G.Start_Kaitun and _G.Start_Saber and Check_Sword("Saber") == true then
				_G.Start_Saber = false
			end
		end)
	end
end)
local SetCFarmeBoneS = 1
function GetBone_CFrame_Mon()
	local matchingCFrames = {}
	local Mon = {"Snow Lurker [Lv. 1375]","Arctic Warrior [Lv. 1350]"}

	for _, Mon in ipairs(Mon) do
		local result = Mon:gsub("Lv. ", ""):gsub("[%[%]]", ""):gsub("%d+", ""):gsub("%s+", "")
		
		for _, v in ipairs(game.workspace.EnemySpawns:GetChildren()) do
			if v.Name == result then
				table.insert(matchingCFrames, v.CFrame)
			end
		end
	end
	
	return matchingCFrames
end


spawn(function()
	pcall(function()
		local MyLevel = game.Players.LocalPlayer.Data.Level.Value
		while wait() do
			if _G.Start_Kaitun and _G.AutoRengoku and Check_Sword("Rengoku") == nil then
				if MyLevel >= 958 then
					_G.StartFarm = false
					_G.Grab_Fruit = false
					Level_SD:Set("Stats : Rengoku")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
					if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key") then
						EquipWeapon("Hidden Key")
						toposition(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
						wait(5)
						_G.StartFarm = true 
						_G.Grab_Fruit = true
						_G.AutoRengoku = false
					elseif game:GetService("Workspace").Enemies:FindFirstChild("Snow Lurker [Lv. 1375]") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior [Lv. 1350]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if (v.Name == "Snow Lurker [Lv. 1375]" or v.Name == "Arctic Warrior [Lv. 1350]") and v.Humanoid.Health > 0 then
								repeat task.wait()
									_G.Grab_Fruit = false
									Level_SD:Set("Stats : Rengoku")
									EquipWeapon(_G.Select_Weapon)
									v.HumanoidRootPart.CanCollide = false
									v.HumanoidRootPart.Size = Vector3.new(50,50,50)
									PosMon = v.HumanoidRootPart.CFrame
									toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,7))
									if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO or _G.SuperFastAttack then
									end
									BringMobFarm556 = true
								until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or _G.AutoRengoku == false or not v.Parent or v.Humanoid.Health <= 0
								BringMobFarm556 = false
							end
						end
					else
						BringMobFarm556 = false
						if (GetBone_CFrame_Mon()[SetCFarmeBoneS].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 then
							Bypass(GetBone_CFrame_Mon()[SetCFarmeBoneS])
						else
							toposition(GetBone_CFrame_Mon()[SetCFarmeBoneS])
						end
						if (GetBone_CFrame_Mon()[SetCFarmeBoneS].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
							if SetCFarmeBoneS == nil or SetCFarmeBoneS == '' then
								SetCFarmeBoneS = 1
							elseif SetCFarmeBoneS >= #GetBone_CFrame_Mon() then
								SetCFarmeBoneS = 1
							end
							SetCFarmeBoneS =  SetCFarmeBoneS + 1

							print(SetCFarmeBoneS)
							wait(0.5)
						end
					end
				end
			elseif _G.Start_Kaitun and _G.AutoRengoku and Check_Sword("Rengoku") == true then
				_G.AutoRengoku = false
			end
		end
	end)
end)

spawn(function()
	while wait() do
		local MyLevel = game.Players.localPlayer.Data.Level.value
		if _G.Start_Kaitun and _G.Midnight_Blade then 
			pcall(function()
				if MyLevel >= 1349 and Check_Sword("Midnight Blade") == nil then
					_G.Grab_Fruit = false
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Check") <= 100 then
						_G.StartFarm = false
						if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand [Lv. 1250]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward [Lv. 1300]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer [Lv. 1325]") then
							if (CFrame.new(911.35827636719, 125.95812988281, 33159.5390625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 then
								Bypass(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
								repeat wait() Bypass(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)) until (CFrame.new(911.35827636719, 125.95812988281, 33159.5390625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 or not _G.Start_Kaitun
							end
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if string.find(v.Name, "Ship") then
									repeat task.wait()
										if string.find(v.Name,"Ship") then
											EquipWeapon(_G.Select_Weapon)
											v.HumanoidRootPart.CanCollide = false
											v.Head.CanCollide = false
											v.HumanoidRootPart.Size = Vector3.new(50,50,50)
											if AttackRandomType == 1 then
												toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
											elseif AttackRandomType == 2 then
												toposition(v.HumanoidRootPart.CFrame * CFrame.new(40, 30, 0))
											elseif AttackRandomType == 3 then
												toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, -40))
											else
												toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
											end
											if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO or _G.SuperFastAttack then
											end
											PosMon = v.HumanoidRootPart.CFrame
											BringMobFarm565 = true
										else
											BringMobFarm565 = false
											toposition(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
										end
									until _G.Midnight_Blade == false or not v.Parent or v.Humanoid.Health <= 0
								end
							end
						else
							BringMobFarm565 = false
							if (CFrame.new(911.35827636719, 125.95812988281, 33159.5390625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500 then
								Bypass(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625))
								repeat wait() Bypass(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)) until (CFrame.new(911.35827636719, 125.95812988281, 33159.5390625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 or not _G.Start_Kaitun
							else
								repeat wait() toposition(CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)) until (CFrame.new(911.35827636719, 125.95812988281, 33159.5390625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 or not _G.Start_Kaitun
							end
						end
					elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Check") >= 100 and Check_Sword("Midnight Blade") == nil then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","BuyCheck",3)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Buy",3)
						_G.Grab_Fruit = true
						wait(1.5)
						_G.Midnight_Blade = false
						wait(2.5)
						_G.StartFarm = true
					end
				elseif Check_Sword("Midnight Blade") == true then
					_G.Midnight_Blade = false
				else
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Check")>= 100 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","BuyCheck",3)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Buy",3)
					end
				end
			end)
		end
	end
end)
spawn(function()
	while wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.Bring_Mob and BringMobFarm565 then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if (v.Name == "Ship Deckhand [Lv. 1250]" or v.Name == "Ship Engineer [Lv. 1275]" or v.Name == "Ship Steward [Lv. 1300]" or v.Name == "Ship Officer [Lv. 1325]" ) and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 250 then
						v.HumanoidRootPart.CFrame = PosMon
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						v.HumanoidRootPart.Size = Vector3.new(60,60,60)
						v.HumanoidRootPart.Transparency = 1
						v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						v.Humanoid:ChangeState(11)
						v.Humanoid:ChangeState(14)
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
					end
				end
			end
		end)
	end
end)

local Yama_All_Mon = {
	["Mon Quest"] = {"Diablo [Lv. 1750]","Deandre [Lv. 1750]","Urban [Lv. 1750]"},
	["Mon"] = {"Diablo","Deandre","Urban"},
	["Item"] = "God's Chalice",
}

spawn(function()
	while wait() do
		if _G.Start_Kaitun and _G.Auto_Yama then
			pcall(function()
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress") >= 30 then
					fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
				else
					local QuestUI = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
					for _,_l1 in ipairs(Yama_All_Mon["Mon Quest"]) do
						for _,l in ipairs(Yama_All_Mon["Mon"]) do
							if QuestUI.Visible == true and _G.StartFarm ~= true then
								if game:GetService("Workspace").Enemies:FindFirstChild(_l1) or game:GetService("ReplicatedStorage"):FindFirstChild(_l1) then
									for _,_v1 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if _v1.Name == _l1 then
											if _v1:FindFirstChild("Humanoid") and _v1:FindFirstChild("HumanoidRootPart") and _v1.Humanoid.Health > 0 then
												repeat wait()
													_v1.HumanoidRootPart.Size = Vector3.new(60,60,60)
													_v1.HumanoidRootPart.CanCollide = false
													_v1.Head.CanCollide = false
													BringMobFarm = true
													EquipWeapon(_G.Select_Weapon)
													_v1.HumanoidRootPart.Transparency = 1
													toposition(_v1.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
													--AutoHaki()
													if (_v1.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
	
													end
												until not _G.Auto_Yama or _v1.Humanoid.Health <= 0 or not _v1.Parent
											end
										else
											if (game:GetService("ReplicatedStorage"):FindFirstChild(_l1).HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
												Bypass(game:GetService("ReplicatedStorage"):FindFirstChild(_l1).HumanoidRootPart.CFrame)
												return
											end
											toposition(game:GetService("ReplicatedStorage"):FindFirstChild(_l1).HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
										end
									end
								end
							else
								if game.Players.LocalPlayer.Backpack:FindFirstChild(Yama_All_Mon["Item"]) or game.Players.LocalPlayer.Character:FindFirstChild(Yama_All_Mon["Item"]) then
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
									_G.Auto_Yama = false
									return
								else
									if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("EliteHunter") == "I don't have anything for you right now. Come back later." and not ( game:GetService("Workspace").Enemies:FindFirstChild(_l1) or game:GetService("ReplicatedStorage"):FindFirstChild(_l1) ) then
										_G.StartFarm = true
									else
										_G.StartFarm = false
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
										if (game:GetService("ReplicatedStorage"):FindFirstChild(_l1).HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
											Bypass(game:GetService("ReplicatedStorage"):FindFirstChild(_l1).HumanoidRootPart.CFrame)
											return
										end
										toposition(game:GetService("ReplicatedStorage"):FindFirstChild(_l1).HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
									end
								end
							end
						end
					end
				end
			end)
		end
	end
end)


spawn(function()
	while wait() do
		pcall(function()
			if _G.Auto_Tushita and _G.Start_Kaitun and Check_Sword("Tushita") == nil then
				if game:GetService("Workspace").Map.Turtle.TushitaGate:GetChildren()[2].Transparency == 1 or game:GetService("Workspace").Map.Turtle.TushitaGate:GetChildren()[1].Transparency == 1 then
					_G.StartFarm = false
					_G.Auto_Yama = false
					if #game:GetService("Workspace").Enemies:GetChildren() > 0 then
						if game:GetService("Workspace").Enemies:FindFirstChild("Longma [Lv. 2000] [Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("Longma [Lv. 2000] [Boss]") then
							for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == "Longma [Lv. 2000] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
									repeat wait()
										v.HumanoidRootPart.Size = Vector3.new(60,60,60)
										v.HumanoidRootPart.CanCollide = false
										v.Head.CanCollide = false
										BringMobFarm = true
										EquipWeapon(_G.Select_Weapon)
										v.HumanoidRootPart.Transparency = 1
										toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
										if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
											
											
										end
									until not _G.Auto_Tushita or not v.Humanoid.Health <= 0 or not v.Parent
								else
									if (game:GetService("ReplicatedStorage"):FindFirstChild("Longma [Lv. 2000] [Boss]").HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
										Bypass(game:GetService("ReplicatedStorage"):FindFirstChild("Longma [Lv. 2000] [Boss]").HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
										return
									end
									toposition(game:GetService("ReplicatedStorage"):FindFirstChild("Longma [Lv. 2000] [Boss]").HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
								end
							end
						end
					end
				else
					if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") or game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form [Lv. 5000] [Raid Boss]") then
						_G.StartFarm = false
						_G.Auto_Yama = false
						if game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value == tostring(GetIsLand(CFrame.new(-13274.528320313, 531.82073974609, -7579.22265625))) then
							wait(1)
							repeat toposition(CFrame.new(-10752, 417, -9366)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-10752, 417, -9366)).Magnitude <= 1
							wait(1)
							repeat toposition(CFrame.new(-11672, 334, -9474)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-11672, 334, -9474)).Magnitude <= 1
							wait(1)
							repeat toposition(CFrame.new(-12132, 521, -10655)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-12132, 521, -10655)).Magnitude <= 1
							wait(1)
							repeat toposition(CFrame.new(-13336, 486, -6985)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-13336, 486, -6985)).Magnitude <= 1
							wait(1)
							repeat toposition(CFrame.new(-13489, 332, -7925)) wait() until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position-Vector3.new(-13489, 332, -7925)).Magnitude <= 1
						else
							if (CFrame.new(5148.03613, 162.352493, 910.548218, 0, 0, -1, 0, 1, 0, 1, 0, 0).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
								Bypass(CFrame.new(5148.03613, 162.352493, 910.548218, 0, 0, -1, 0, 1, 0, 1, 0, 0))
								return
							end
							toposition(CFrame.new(5148.03613, 162.352493, 910.548218, 0, 0, -1, 0, 1, 0, 1, 0, 0))
							wait(2.5)
							return
						end
					end
				end
			else
				if not _G.Auto_Yama then
					_G.StartFarm = true
				end
				_G.Auto_Tushita = false
			end
		end)
	end
end)

spawn(function()
	while wait() do
		if _G.Auto_Factory_Farm and _G.Start_Kaitun and W2 then
			pcall(function()
				if game.Workspace.Enemies:FindFirstChild("Core") then
					_G.StartFarm = false
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if _G.FactoryCore and v.Name == "Core" and v.Humanoid.Health > 0 then
							repeat wait()
								----AutoHaki()
								EquipWeapon(_G.Select_Weapon)
								toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,10,10))
								game:GetService'VirtualUser':CaptureController()
								game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
							until not _G.FactoryCore or v.Humanoid.Health <= 0 or _G.Auto_Factory_Farm == false
						end
					end
				elseif game.ReplicatedStorage:FindFirstChild("Core") and game.ReplicatedStorage:FindFirstChild("Core"):FindFirstChild("Humanoid") then
					if (CFrame.new(502.7349853515625, 143.0749053955078, -379.078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 2000 then
						Bypass(CFrame.new(502.7349853515625, 143.0749053955078, -379.078125))
					else
						toposition(CFrame.new(502.7349853515625, 143.0749053955078, -379.078125))
					end
				else
					if (not _G.AutoRengoku and _G.AutoRengoku == nil ) and _G._G.Start_Kaitun == nil and _G.Thire_World == nil and W2 then
						_G.StartFarm = true
					end
				end
			end)
		end
	end
end)


function getTrophies(Amount)
	for i,v in pairs(game:GetService("Workspace").Map["Haunted Castle"].Trophies.Quest:GetChildren()) do
		if v.Handle.Orientation then
			local NameTro = tonumber(tostring(v.Name:match("%d+")))
			if tonumber(Amount) == tonumber(NameTro) then
				if tonumber(v.Handle.Orientation.Y) == 90 or tonumber(v.Handle.Orientation.Y) == -90 then
					return {"A", 180, -180}
				elseif tonumber(v.Handle.Orientation.Y) == 0 or tonumber(v.Handle.Orientation.Y) == 180 then
					return {"B", -90, 90}
				end
			end
		end
	end
end

function InMyNetWork2(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 750 then 
			return true
		end
		return false
	end
end
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.BringNormal and BringMobFarmGuitar then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					PositionMon = 750
					if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= PositionMon then
						if InMyNetWork2(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMon
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.Size = Vector3.new(60,60,60)
							v.HumanoidRootPart.Transparency = 1
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid:ChangeState(14)
							sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
						end
					end
				end
			end
		end)
	end
end)
local Number2 = 1
local BoneTabel = {
	["Mon"] = {"Reborn Skeleton [Lv. 1975]","Demonic Soul [Lv. 2025]","Living Zombie [Lv. 2000]","Posessed Mummy [Lv. 2050]"},
	["Boss"] = {"Soul Reaper [Lv. 2100] [Raid Boss]"},
	["Item"] = "Hallow Essence",
}

local SetCFarmeBone = 1
function GetBone_CFrame_Mon()
	local matchingCFrames = {}
	for _, Mon in ipairs(BoneTabel["Mon"]) do
		local result = Mon:gsub("Lv. ", ""):gsub("[%[%]]", ""):gsub("%d+", ""):gsub("%s+", "")
		for _, v in ipairs(game.workspace.EnemySpawns:GetChildren()) do
			if v.Name == result then
				table.insert(matchingCFrames, v.CFrame)
			end
		end
	end
	return matchingCFrames
end
_G.Poo = 1500
spawn(function()
	while wait() do
		pcall(function()
			if _G.Auto_Soul_Guitar and _G.Start_Kaitun and game.Players.localPlayer.Data.Level.value >= 2300 and Check_Gun("Soul Guitar") == nil then
				local data = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check")
				if data == nil then
					if game:GetService("Lighting").Sky.MoonTextureId=="http://www.roblox.com/asset/?id=9709149431" then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
						_G.StartFarm = false
					elseif data == nil then
						return
					end
				end
				for i, v in pairs(data) do
					if i == "Swamp" then
						if v == false then
							_G.StartFarm = false
							if game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") then
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Living Zombie [Lv. 2000]" then
										if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat wait()
												PosMon = CFrame.new(-10164.7588, 138.652451, 5935.78418, -0.999782741, -8.01260214e-08, -0.0208426975, -7.95026338e-08, 1, -3.07377839e-08, 0.0208426975, -2.90740569e-08, -0.999782741)
												EquipWeapon(_G.Select_Weapon)
												v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
												BringMobFarmGuitar = true
												toposition(CFrame.new(-10164.7588, 138.652451, 5935.78418, -0.999782741, -8.01260214e-08, -0.0208426975, -7.95026338e-08, 1, -3.07377839e-08, 0.0208426975, -2.90740569e-08, -0.999782741) * CFrame.new(0, 30, 5))
											until not _G.Auto_Soul_Guitar or v.Humanoid.Health <= 0 or not v.Parent or v.Humanoid.Health <= 0 
										end
									end
								end
							else
								toposition(CFrame.new(-10164.7588, 138.652451, 5935.78418, -0.999782741, -8.01260214e-08, -0.0208426975, -7.95026338e-08, 1, -3.07377839e-08, 0.0208426975, -2.90740569e-08, -0.999782741))
							end
						else
							for _i,_v in pairs(data) do
								if _i == "Gravestones" then
									if _v == false then
										_G.StartFarm = false
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard7.Left.ClickDetector)
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard6.Left.ClickDetector)
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard5.Left.ClickDetector)
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard4.Right.ClickDetector)
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard3.Left.ClickDetector)
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard2.Right.ClickDetector)
										wait(0.2)
										fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard1.Right.ClickDetector)
									else
										for _i1,_v1 in pairs(data) do
											if _i1 == "Ghost" then
												if _v1 == false then
													_G.StartFarm = false
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
												else
													for _i2,_v2 in pairs(data) do
														if _i2 == "Trophies" then
															if _v2 == false then
																_G.StartFarm = false
																repeat wait()
																	fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"))
																until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment2.Line.Position.Y == -1000 or not _G.Auto_Soul_Guitar
																repeat wait()
																	fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"))
																until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment5.Line.Position.Y == -1000 or not _G.Auto_Soul_Guitar
																repeat wait()
																	fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"))
																until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment6.Line.Position.Y == -1000 or not _G.Auto_Soul_Guitar
																repeat wait()
																	fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"))
																until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment8.Line.Position.Y == -1000 or not _G.Auto_Soul_Guitar
																repeat wait()
																	fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"))
																until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment9.Line.Position.Y == -1000 or not _G.Auto_Soul_Guitar
																if getTrophies(1)[1] then
																	repeat wait()
																		fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"))
																	until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1.Line.Rotation.Z == getTrophies(1)[2] or game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1.Line.Rotation.Z == getTrophies(1)[3] or not _G.Auto_Soul_Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Trophies == true
																end
																if getTrophies(2)[1] then
																	repeat wait()
																		fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"))
																	until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment3.Line.Rotation.Z == getTrophies(2)[2] or game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment3.Line.Rotation.Z == getTrophies(1)[3] or not _G.Auto_Soul_Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Trophies == true
																end
																if getTrophies(3)[1] then
																	repeat wait()
																		fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"))
																	until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment4.Line.Rotation.Z == getTrophies(3)[2] or game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment4.Line.Rotation.Z == getTrophies(1)[3] or not _G.Auto_Soul_Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Trophies == true
																end
																if getTrophies(4)[1] then
																	repeat wait()
																		fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"))
																	until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment7.Line.Rotation.Z == getTrophies(4)[2] or game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment7.Line.Rotation.Z == getTrophies(1)[3] or not _G.Auto_Soul_Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Trophies == true
																end
																if getTrophies(5)[1] then
																	repeat wait()
																		fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"))
																	until game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment10.Line.Rotation.Z == getTrophies(5)[2] or  game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment10.Line.Rotation.Z == getTrophies(1)[3] or not _G.Auto_Soul_Guitar or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GuitarPuzzleProgress","Check").Trophies == true
																end
															else
																for _i3,_v3 in pairs(data) do
																	if _i3 == "Pipes" then
																		if _v3 == false then
																			_G.StartFarm = false
																			repeat task.wait() toposition(CFrame.new(-9628.02734375, 6.13064432144165, 6157.47802734375)) until not _G.Auto_Soul_Guitar or (CFrame.new(-9628.02734375, 6.13064432144165, 6157.47802734375).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10               
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
																			wait()
																			fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
																		else
																			for _i4,_v4 in pairs(data) do
																				if _i4 == "CraftedOnce" then
																					if _v4 == false then
																						_G.StartFarm = false
																						if Check_Material("Bones") < 500 and W3 then
																							for _, _Boss in ipairs(BoneTabel["Boss"]) do
																								local _Item = BoneTabel["Item"]
																								if game:GetService("Workspace").Enemies:FindFirstChild(_Boss) or game:GetService("ReplicatedStorage"):FindFirstChild(_Boss) then
																									for _, _v1 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																										if _v1.Name == _Boss then
																											if _v1:FindFirstChild("Humanoid") and _v1:FindFirstChild("HumanoidRootPart") and _v1.Humanoid.Health > 0 then
																												repeat wait()
																													EquipWeapon(_G.Select_Weapon)
																													_v1.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
																													BringMobFarm = true
																													toposition(_v1.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
																													if (_v1.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
																														game:GetService("VirtualUser"):CaptureController()
																														game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
																													end
																												until not _G.Auto_Soul_Guitar or v.Humanoid.Health <= 0 or not v.Parent or v.Humanoid.Health <= 0
																												BringMobFarm = false
																											end
																										end
																									end
																								else
																									if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(_Item) or game:GetService("Players").LocalPlayer.Character:FindFirstChild(_Item) then
																										EquipWeapon(_Item)
																										toposition(workspace.Map["Haunted Castle"].Summoner.Detection.CFrame)
																									else
																										for _, _Mon in next, BoneTabel["Mon"] do
																											if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton [Lv. 1975]") or game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie [Lv. 2000]") or game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul [Lv. 2025]") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy [Lv. 2050]") then
																												print(_Mon)
																												for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																													if v.Name == _Mon then
																														if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
																															repeat wait()
																																PosMon = v.HumanoidRootPart.CFrame
																																EquipWeapon(_G.Select_Weapon)
																																v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
																																BringMobFarm = true
																																toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
																																if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
																																	game:GetService("VirtualUser"):CaptureController()
																																	game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
																																end
																															until not _G.Auto_Soul_Guitar or v.Humanoid.Health <= 0 or not v.Parent or v.Humanoid.Health <= 0
																														else
																															toposition(GetBone_CFrame_Mon()[SetCFarmeBone] * CFrame.new(0,30,5))
																															if (GetBone_CFrame_Mon()[SetCFarmeBone].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
																																if SetCFarmeBone == nil or SetCFarmeBone == '' then
																																	SetCFarmeBone = 1
																																elseif SetCFarmeBone >= #GetBone_CFrame_Mon() then
																																	SetCFarmeBone = 1
																																end
																																SetCFarmeBone =  SetCFarmeBone + 1
																							
																																print(SetCFarmeBone)
																																wait(0.5)
																															end
																														end
																													end
																												end
																											else
																												toposition(GetBone_CFrame_Mon()[SetCFarmeBone] * CFrame.new(0,30,5))
																												if (GetBone_CFrame_Mon()[SetCFarmeBone].Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
																													if SetCFarmeBone == nil or SetCFarmeBone == '' then
																														SetCFarmeBone = 1
																													elseif SetCFarmeBone >= #GetBone_CFrame_Mon() then
																														SetCFarmeBone = 1
																													end
																													SetCFarmeBone =  SetCFarmeBone + 1
																				
																													print(SetCFarmeBone)
																													wait(0.5)
																												end
																											end
																										end
																									end
																								end
																							end
																						else
																							if Check_Material("Bones") > 500 then
																								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Check") < 250 then
																									if not W2 then
																										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
																									else
																										if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand [Lv. 1250]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer [Lv. 1275]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward [Lv. 1300]") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer [Lv. 1325]") then
																											for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
																												if string.find(v.Name, "Ship") then
																													repeat wait()
																														--AutoHaki()
																														EquipWeapon(_G.Select_Weapon)
																														PosMonEctoplasm = v.HumanoidRootPart.CFrame
																														v.HumanoidRootPart.CanCollide = false
																														v.HumanoidRootPart.Size = Vector3.new(50,50,50)
																														toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
																														MagnetEctoplasm = true
																														game:GetService'VirtualUser':CaptureController()
																														game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
																													until _G.Auto_Soul_Guitar == false or not v.Parent or v.Humanoid.Health <= 0
																													MagnetEctoplasm = false
																												else
																													MagnetEctoplasm = false
																													toposition(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
																												end
																											end
																										else 
																											MagnetEctoplasm = false
																											local Distance = (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
																											if Distance > 20000 then
																												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
																											end
																											toposition(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
																										end
																									end
																								elseif Check_Material("Dark Fragment") < 1 then
																									if not W2 then
																										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
																									end
																									if game.ReplicatedStorage:FindFirstChild("Darkbeard [Lv. 1000] [Raid Boss]") or game.Workspace.Enemies:FindFirstChild("Darkbeard [Lv. 1000] [Raid Boss]") then
																										toposition(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375))
																										for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
																											if v.Name == "Darkbeard [Lv. 1000] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
																												repeat wait()  
																													EquipWeapon(_G.Select_Weapon)
																													v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)  
																													toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
																													if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
																														game:GetService("VirtualUser"):CaptureController()
																														game:GetService("VirtualUser"):Button1Down(Vector2.new(1280,672))
																													end
																												until not _G.Auto_Soul_Guitar or v.Humanoid.Health <= 0 or not v.Parent
																											end
																										end
																									else
																										if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") then
																											EquipWeapon("Fist of Darkness")
																											toposition(CFrame.new(3780.0302734375, 22.652164459229, -3498.5859375) * CFrame.new(0,-10,0))
																										else
																											if not W2 then
																												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
																											end
																											for i,v in pairs(game:GetService("Workspace"):GetChildren()) do 
																												if v.Name:find("Chest") then
																													if game:GetService("Workspace"):FindFirstChild(v.Name) then
																														if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000+_G.Poo then
																															repeat task.wait()
																																if game:GetService("Workspace"):FindFirstChild(v.Name) then
																																	toposition(v.CFrame)
																																	if (v.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
																																		UnEquipWeapon(_G.Select_Weapon)
																																	else
																																		EquipWeapon(_G.Select_Weapon)
																																	end
																																else
																																	_G.Poo = _G.Poo + 1000
																																end
																															until _G.Auto_Soul_Guitar  == false or not v.Parent
																															_G.Poo = _G.Poo + 1000
																															break
																														else
																															_G.Poo = _G.Poo + 1000
																														end
																													end
																												end
																											end
																										end
																									end
																								else
																									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm","Check") > 250 and Check_Material("Dark Fragment") > 1 then
																										if W3 then
																											print("Buy")
																											_G.Auto_Soul_Guitar = false
																											_G.StartFarm = true
																										else
																											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
																										end
																									end
																								end
																							end
																						end
																					end
																				end
																			end
																		end
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end 
		end)
	end
end)
spawn(function()
	game:GetService("RunService").Heartbeat:Connect(function()
		pcall(function()
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
				if _G.Auto_Soul_Guitar and MagnetEctoplasm and string.find(v.Name, "Ship") and (v.HumanoidRootPart.Position - PosMonEctoplasm.Position).magnitude <= 350 then
					v.HumanoidRootPart.CFrame = PosMonEctoplasm
					v.HumanoidRootPart.CanCollide = false
					v.HumanoidRootPart.Size = Vector3.new(50,50,50)
					if v.Humanoid:FindFirstChild("Animator") then
						v.Humanoid.Animator:Destroy()
					end
					sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
				end
			end
		end)
	end)
end)

_G.GoGat = true
spawn(function()
	while wait(0) do
		if _G.Start_Kaitun then
			MyLevel = game.Players.localPlayer.Data.Level.value
			if MyLevel >= 15 then
				for i,v in pairs(Code) do
					pcall(function()
						local args = {
							[1] = v
						}
						game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(unpack(args))
					end)
				end
				break
			end
		end
	end
end)

spawn(function()
	while wait() do
		if _G.Start_Kaitun and _G.StoreFruit then
			pcall(function()
				wait()
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bomb Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Bomb-Bomb",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bomb Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spike Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Spike-Spike",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spike Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Chop Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chop Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Chop-Chop",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Chop Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chop Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spring Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Spring-Spring",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spring Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kilo Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Kilo-Kilo",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kilo Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Smoke Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Smoke-Smoke",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Smoke Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Spin-Spin",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Flame-Flame",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Falcon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Falcon Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Bird-Bird: Falcon",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Falcon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Falcon Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Ice-Ice",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Sand-Sand",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Dark-Dark",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Revive Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Revive-Revive",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Revive Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Diamond Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Diamond-Diamond",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Diamond Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Light-Light",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Love Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Love-Love",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Love Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rubber Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Rubber-Rubber",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rubber Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Barrier Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Barrier-Barrier",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Barrier Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Magma-Magma",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Door Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Door Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Door-Door",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Door Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Door Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Quake-Quake",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Human-Human: Buddha Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Human-Human: Buddha",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Human-Human: Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Human-Human: Buddha Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("String Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("String Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","String-String",game:GetService("Players").LocalPlayer.Character:FindFirstChild("String Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("String Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Phoenix Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Bird-Bird: Phoenix",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bird: Phoenix Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Rumble-Rumble",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Paw Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Paw Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Paw-Paw",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Paw Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Paw Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Gravity-Gravity",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Dough-Dough",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Shadow-Shadow",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Venom-Venom",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Control-Control",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Dragon-Dragon",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit","Leopard-Leopard",game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit")) wait(0.3) game.Players.LocalPlayer.Character.Head:Destroy() 
				end
			end)
		end
	end
end)


spawn(function()
	while task.wait() do 
		pcall(function()
			if _G.Start_Kaitun and _G.Auto_Superhuman then

				if _G.StartFarm == true then
					for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v.ToolTip == "Melee" then
							if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
                                SelectWeapon = v.Name
							end
						end
					end

				if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Combat") then
					local args = {
						[1] = "BuyElectro"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Electro") and game.Players.LocalPlayer.Backpack:FindFirstChild("Electro").Level.Value >= 300 then
					local args = {
						[1] = "BuyBlackLeg"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Electro") and game.Players.LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 300 then
					local args = {
						[1] = "BuyBlackLeg"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Backpack:FindFirstChild("Black Leg").Level.Value >= 300 then
					local args = {
						[1] = "BuyFishmanKarate"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 300 then
					local args = {
						[1] = "BuyFishmanKarate"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end

				if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300 then
					if game.Players.LocalPlayer.Data.Fragments.Value <= 1500 then
						if game.Players.LocalPlayer.Data.Level.Value >= 1100 then
							_G.StartFarm = false
							_G.StoreFruit = false
							_G.Grab_Fruit = false
							_G.Auto_Yama = false
							if _G.StartFarm == false or not _G.StartFarm then
								_G.StartFarm = false
								_G.StoreFruit = false
								_G.Grab_Fruit = false
								_G.Auto_Yama = false
								_G.Auto_Dungeon_Superhuman = _G.Auto_Superhuman
								

								local FruitPrice = {}
								local FruitStore = {}

								for i,v in next,game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
									if v.Price <= 500000 then  
										table.insert(FruitPrice,v.Name)
									end
								end
								for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
									for _,x in pairs(v) do
										if _ == "Name" then 
											table.insert(FruitStore,x)
										end
									end
								end

								for _,y in pairs(FruitPrice) do
									for _,z in pairs(FruitStore) do
										if y == z then
											for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
												if tool:FindFirstChild("Fruit") then
												else
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
													local args = {
														[1] = "LoadFruit",
														[2] = tostring(y)
													}

													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
												end
											end
										end
									end 
								end
								wait(0.5)
								local args = {
									[1] = "RaidsNpc",
									[2] = "Select",
									[3] = tostring("Light")
								}
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))

								if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == false and _G.JoinD == nil then
									if W2 then
										wait(1.5)
										fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
										wait(5)
										_G.JoinD = true
										wait(1.2)
										if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == false and _G.JoinD == true then
											_G.JoinD = nil
										end
									elseif W3 then
										wait(1.5)
										fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
										wait(5)
										_G.JoinD = true
										wait(1.2)
										if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.Timer.Visible == false and _G.JoinD == true then
											_G.JoinD = nil
										end
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										pcall(function()
											repeat wait(.1)
												sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
												v.Humanoid.Health = 0
												v.HumanoidRootPart.CanCollide = false
												v.HumanoidRootPart.Size = Vector3.new(500,500,500)
												v.HumanoidRootPart.Transparency = 1
											until not _G.Auto_Dungeon_Superhuman or not v.Parent or v.Humanoid.Health <= 0
										end)
									end
								end
								for i,v in pairs(game.Workspace.Enemies:GetDescendants()) do
									if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
										pcall(function()
											repeat wait()
												v.Humanoid.Health = 0
												v.HumanoidRootPart.CanCollide = false
												v.HumanoidRootPart.Size = Vector3.new(500,500,500)
												v.HumanoidRootPart.Transparency = 1
											until not _G.Auto_Dungeon_Superhuman or not v.Parent or v.Humanoid.Health <= 0
										end)
									end
								end
								if not game.Players.LocalPlayer.PlayerGui.Main.Timer.Visible == false then
									if game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5") then
										getgenv().TP(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 5").CFrame * CFrame.new(0,70,100))
									elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4") then
										getgenv().TP(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 4").CFrame * CFrame.new(0,70,100))
									elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3") then
										getgenv().TP(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 3").CFrame * CFrame.new(0,70,100))
									elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2") then
										getgenv().TP(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 2").CFrame * CFrame.new(0,70,100))
									elseif game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") then
										getgenv().TP(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").CFrame * CFrame.new(0,70,100))
									end
								end
							end
						else
							_G.StartFarm = true
							_G.StoreFruit = true
							_G.Grab_Fruit = true
							_G.Auto_Yama = true
							_G.JoinD = nil
							_G.Auto_Dungeon_Superhuman = nil
						end
					end
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") and game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate").Level.Value >= 300 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
				end
				if game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") and game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw").Level.Value >= 300 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
				end
				if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman",true) == 1 then
					_G.Auto_Superhuman = false
				end
			end
		end
	end)
end
end)

spawn(function()
	while task.wait() do 
		pcall(function()
			if _G.Start_Kaitun and _G.Auto_Electric_Claw then
				if game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") and game.Players.LocalPlayer.Character:FindFirstChild("Superhuman").Level.Value >= 300 and _G.Auto_Superhuman == false then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
				end
				if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Electro") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") then
					if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electro").Level.Value >= 400 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true) == 1 then
							if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electric Claw") or game:GetService("Players").LocalPlayer.backpack:FindFirstChild("Electric Claw") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
							end
						else
							_G.StartFarm = false
							_G.StoreFruit = false
							_G.Grab_Fruit = false
							_G.Auto_Yama = false
							repeat task.wait()
								_G.StartFarm = false
								_G.StoreFruit = false
								_G.Grab_Fruit = false
								_G.Auto_Yama = false
								toposition(CFrame.new(-10371.4717, 330.764496, -10131.4199))
							until not _G.Start_Kaitun or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw","Start")
							wait(2)
							repeat task.wait()
								_G.StartFarm = false
								_G.StoreFruit = false
								_G.Grab_Fruit = false
								_G.Auto_Yama = false
								toposition(CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438))
							until not _G.Start_Kaitun or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-12550.532226563, 336.22631835938, -7510.4233398438).Position).Magnitude <= 10
							wait(1)
							repeat task.wait()
								_G.StartFarm = false
								_G.StoreFruit = false
								_G.Grab_Fruit = false
								_G.Auto_Yama = false
								toposition(CFrame.new(-10371.4717, 330.764496, -10131.4199))
							until not _G.Start_Kaitun or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(-10371.4717, 330.764496, -10131.4199).Position).Magnitude <= 10
							wait(1)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
							wait(0.5)
							_G.StartFarm = true
							_G.StoreFruit = true
							_G.Grab_Fruit = true
							_G.Auto_Yama = true
						end
					end
				end
			end
		end)
	end
end)

FruitList = {
	"Bomb-Bomb",
	"Spike-Spike",
	"Chop-Chop",
	"Spring-Spring",
	"Kilo-Kilo",
	"Spin-Spin",
	"Bird: Falcon",
	"Smoke-Smoke",
	"Flame-Flame",
	"Ice-Ice",
	"Sand-Sand",
	"Dark-Dark",
	"Revive-Revive",
	"Diamond-Diamond",
	"Light-Light",
	"Love-Love",
	"Rubber-Rubber",
	"Barrier-Barrier",
	"Magma-Magma",
	"Door-Door",
	"Quake-Quake",
	"Human-Human: Buddha",
	"String-String",
	"Bird-Bird: Phoenix",
	"Rumble-Rumble",
	"Paw-Paw",
	"Gravity-Gravity",
	"Dough-Dough",
	"Venom-Venom",
	"Shadow-Shadow",
	"Control-Control",
	"Soul-Soul",
	"Dragon-Dragon"
}

spawn(function()
    local Player_level = game.Players.LocalPlayer.Data.Level.Value
    local QuestC = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
    while wait() do
        if _G.Start_GoTo_Thire_World and _G.Start_Kaitun and W2 and Player_level >= 1500 and game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") ~= 0 then
            pcall(function()
				_G.Thire_World = true
				_G.StartFarm = false
				_G.Grab_Fruit = false
				_G.StoreFruit = false
				if game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
					if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
							if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 0 then
								if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") then
									for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if v.Name == "rip_indra [Lv. 1500] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
											repeat wait()
												v.HumanoidRootPart.Size = Vector3.new(60,60,60)
												v.HumanoidRootPart.CanCollide = false
												v.Head.CanCollide = false
												EquipWeapon(_G.Select_Weapon)
												v.HumanoidRootPart.Transparency = 1
												toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
												----AutoHaki()
												if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
												end
											until not _G.Auto_Third_World or not v.Parent or v.Humanoid.Health <= 0 
											_G.Thire_World = nil
											repeat wait() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") until LOL == "LOLOL"
										end
									end
								else
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check")
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Begin")
								end
							elseif game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
								_G.Start_GoTo_Thire_World = false
							else
								--game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress","Check") ~= 0 then
									if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") or game.ReplicatedStorage:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then
										for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
											if v.Name == "Don Swan [Lv. 1000] [Boss]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
												repeat wait()
													v.HumanoidRootPart.Size = Vector3.new(60,60,60)
													v.HumanoidRootPart.CanCollide = false
													v.Head.CanCollide = false
													EquipWeapon(_G.Select_Weapon)
													v.HumanoidRootPart.Transparency = 1
													toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
													if (v.HumanoidRootPart.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
													end
												until not _G.Auto_Third_World or not v.Parent or v.Humanoid.Health <= 0 
											else
												toposition(game.ReplicatedStorage:FindFirstChild("Don Swan [Lv. 1000] [Boss]").HumanoidRootPart.CFrame * CFrame.new(0,30,5))
											end
										end
									else
										toposition(CFrame.new(2207.38672, 15.1333914, 883.866394, 0.931175113, 3.09244754e-08, -0.364572287, 1.20643637e-08, 1, 1.15638279e-07, 0.364572287, -1.12077821e-07, 0.931175113))
									end
								end
							end
						else
							_G.StoreFruit = false
							for i,v in next,game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
								if v.Price >= 1000000 then  
									table.insert(FruitPrice,v.Name)
								else
									for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
										if string.find(v.Name, "Fruit") then
											if v:IsA("Tool") then
												_G.StartFarm = false
												wait(1.5)
												if (v.Handle.CFrame.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
													
													Bypass(v.Handle.CFrame * CFrame.new(0,50,0))
													toposition(v.Handle.CFrame)
												else
													toposition(v.Handle.CFrame)
												end
											end
										elseif not v:IsA("Tool") then
											
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
											wait(0.1)
										end
									end
								end
							end
							for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
								for _,x in pairs(v) do
									if _ == "Name" then 
										table.insert(FruitStore,x)
									end
								end
							end
							function CheckFruit()
								local player = game.Players.LocalPlayer
								for _, tool in pairs(player.Backpack:GetDescendants()) do
									if tool:FindFirstChild("Fruit") then
										return tool
									end
								end
							end
							function AddToNpc()
								if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(CheckFruit())) then
									wait(1.5)
									EquipWeapon(tostring(CheckFruit()))
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","2")
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1")
									wait(0.5)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","3")
								end
							end
							for _,y in pairs(FruitPrice) do
								for _,z in pairs(FruitStore) do
									if y == z and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
										local args = {
											[1] = "LoadFruit",
											[2] = tostring(y)
										}
							
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
								end 
							end
						end
						AddToNpc()
					else
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
							_G.Grab_Fruit = false
							_G.StartFarm = false
							Level_SD:Set("Stats : Bartilo Quest")
							if QuestC.Visible == true then
								if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
									for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if v.Name == "Swan Pirate [Lv. 775]" then
											if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
												repeat task.wait()
													if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate") then
														game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
													else
														PosMon = v.HumanoidRootPart.CFrame
														v.HumanoidRootPart.Size = Vector3.new(60,60,60)
														v.HumanoidRootPart.CanCollide = false
														v.Humanoid.WalkSpeed = 0
														v.Head.CanCollide = false
														BringMobFarm = true
														EquipWeapon(_G.Select_Weapon)
														v.HumanoidRootPart.Transparency = 1
														toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))

														if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO then
															
															
														end
													end
												until not _G.Start_GoTo_Thire_World or not v.Parent or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
											end
										end
									end
								else
									for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
										if v.Name == "Swan Pirate" then local CFrameEnemySpawns = v.CFrame  wait(0.5)
											toposition(CFrameEnemySpawns * CFrame.new(0, 30, 5))
										end
									end
								end
							else
								repeat wait() toposition(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312)) until (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.Auto_Bartilo_Quest
								if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
									BringMobFarm = false
									game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
								end
							end
						elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
							_G.StartFarm = false
							Level_SD:Set("Stats : Bartilo Quest")
							if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
								for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if v.Name == "Jeremy [Lv. 850] [Boss]" then
										if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
											repeat task.wait()
												PosMon = v.HumanoidRootPart.CFrame
												v.HumanoidRootPart.Size = Vector3.new(60,60,60)
												v.HumanoidRootPart.CanCollide = false
												v.Humanoid.WalkSpeed = 0
												v.Head.CanCollide = false
												BringMobFarm = true
												EquipWeapon(_G.Select_Weapon)
												v.HumanoidRootPart.Transparency = 1
												toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))

												if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO then
													
													
												end
											until not _G.Start_GoTo_Thire_World or not v.Parent or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
										end
									end
								end
							else
								toposition(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
								if not game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") and (CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
									if not game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
										Hop()
									end
								end
							end
						elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
							Level_SD:Set("Stats : Bartilo Quest")
							repeat wait() toposition(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456)) until (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 or _G.Auto_Bartilo_Quest == false
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
							wait(0.7)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
							wait(0.7)
						end
					end
				else
					
					if not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
						if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 0 then
							toposition(CFrame.new(-2779.83521, 72.9661407, -3574.02002, -0.730484903, 6.39014104e-08, -0.68292886, 3.59963224e-08, 1, 5.50667032e-08, 0.68292886, 1.56424669e-08, -0.730484903))
							if (Vector3.new(-2779.83521, 72.9661407, -3574.02002) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
								wait(1.3)
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","2")
							end
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 1 then
							pcall(function()
								if not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 1") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 1") then
									toposition(game:GetService("Workspace").Flower1.CFrame)
								elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 2") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 2") then
									toposition(game:GetService("Workspace").Flower2.CFrame)
								elseif not game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 3") then
									if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
										for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
											if v.Name == "Swan Pirate [Lv. 775]" then
												repeat wait()
													EquipWeapon(_G.Select_Weapon)
													toposition(v.HumanoidRootPart.CFrame * CFrame.new(0,30,5))
													v.HumanoidRootPart.CanCollide = false
													v.HumanoidRootPart.Size = Vector3.new(50,50,50)
													game:GetService'VirtualUser':CaptureController()
													game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
													PosMon = v.HumanoidRootPart.CFrame
													BringMobFarm = true
												until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or not v.Parent or v.Humanoid.Health <= 0 or _G.Auto_Evo_Race_V2 == false
												BringMobFarm = false
											end
										end
									else
										BringMobFarm = false
										toposition(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
									end
								end
							end)
						elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","1") == 2 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist","3")
						end
					end
				end
            end)
        end
    end
end)

function EquipWeapon(ToolSe)
	if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
		local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
		wait(.4)
		game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
	end
end
spawn(function()
	while wait() do
		for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.ToolTip == "Melee" then
				if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
					_G.Select_Weapon = v.Name
					--EquipWeapon(_G.Select_Weapon)
				end
			end
		end
	end
end)
local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(g:GetDescendants()) do
	if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
		v.Material = "Plastic"
		v.Reflectance = 0
	elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
		v.Transparency = 1
	elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
		v.Lifetime = NumberRange.new(0)
	elseif v:IsA("Explosion") then
		v.BlastPressure = 1
		v.BlastRadius = 1
	elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
		v.Enabled = false
	elseif v:IsA("MeshPart") then
		v.Material = "Plastic"
		v.Reflectance = 0
		v.TextureID = 10385902758728957
	end
end
for i, e in pairs(l:GetChildren()) do
	if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
		e.Enabled = false
	end
end
spawn(function()
	while wait() do
		if _G.Start_Kaitun then
			if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
			end
		end
	end
end)
local InputService = game:GetService('UserInputService')
InputService.WindowFocused:Connect(function()
	game:GetService("RunService"):Set3dRenderingEnabled(true)
end)
InputService.WindowFocusReleased:Connect(function()
	game:GetService("RunService"):Set3dRenderingEnabled(false)
end)
spawn(function()
	while wait() do
		if _G.Start_Kaitun and game.Players.LocalPlayer.Data.Level.Value >= 350 and _G.Start_Kaitun == nil then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Musket")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cannon")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
		end
	end
end)
spawn(function()
while wait() do
	if _G.Start_Kaitun and W2 and game:GetService("Players").LocalPlayer.Data.Beli.Value >= 2000 then
		pcall(function()
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
		end)
	end 
end
end)
spawn(function()
while wait() do
	if _G.Start_Kaitun then
		getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
			if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
				game:GetService("TeleportService"):Teleport(game.PlaceId)
			end
		end)
	end
end
end)
spawn(function()
while wait() do
	pcall(function()
		if _G.Start_Kaitun and _G.Auto_New_World and W1 then
			if game.Players.LocalPlayer.Data.Level.Value >= 700 then
				_G.StartFarm = false
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
				
				if game.Workspace.Map.Ice.Door.CanCollide == true and game.Workspace.Map.Ice.Door.Transparency == 0 then
					wait(.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
					EquipWeapon("Key")
					repeat wait() toposition(CFrame.new(1347.7124, 37.3751602, -1325.6488)) until (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Settings.Main["Auto New World"]
				elseif game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 then
					if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v.Humanoid.Health > 0 then
								repeat wait()
									if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
									end
									v.HumanoidRootPart.Size = Vector3.new(60,60,60)
									v.HumanoidRootPart.Transparency = 1
									v.Humanoid.JumpPower = 0
									v.Humanoid.WalkSpeed = 0
									v.HumanoidRootPart.CanCollide = false
									v.Humanoid:ChangeState(11)
									EquipWeapon(_G.Select_Weapon)
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
									
									toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))
									
									if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO or _G.SuperFastAttack then
										
										
									end
								until v.Humanoid.Health <= 0 or not v.Parent
								game:GetService("ReplicatedStorage"):InvokeServer("TravelDressrosa")
							end
						end
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						toposition(CFrame.new(1347.7124, 37.3751602, -1325.6488))
					end
				else
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
				end
			end
		end
	end)
end
end)
spawn(function()
while wait() do
local MyLevel = game.Players.LocalPlayer.Data.Level.Value
local QuestC = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
	pcall(function()
		if _G.Start_Kaitun and _G.Auto_Bartilo_Quest and MyLevel >= 850 then
			if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
				_G.StartFarm = false
				_G.Grab_Fruit = false
				Level_SD:Set("Stats : Bartilo Quest")
				if QuestC.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if v.Name == "Swan Pirate [Lv. 775]" then
								if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
									repeat task.wait()
										if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate") then
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
										else
											PosMon = v.HumanoidRootPart.CFrame
											v.HumanoidRootPart.Size = Vector3.new(60,60,60)
											v.HumanoidRootPart.CanCollide = false
											v.Humanoid.WalkSpeed = 0
											v.Head.CanCollide = false
											BringMobFarm = true
											EquipWeapon(_G.Select_Weapon)
											v.HumanoidRootPart.Transparency = 1
											toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))

											if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO then
												
												
											end
										end
									until not _G.Auto_Bartilo_Quest or not v.Parent or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
								end
							end
						end
					else
						for i,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
							if v.Name == "Swan Pirate" then local CFrameEnemySpawns = v.CFrame  wait(0.5)
								toposition(CFrameEnemySpawns * CFrame.new(0, 30, 5))
							end
						end
					end
				else
					repeat wait() toposition(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312)) until (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.Auto_Bartilo_Quest
					if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 then
						BringMobFarm = false
						game:GetService('ReplicatedStorage').Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
					end
				end
			elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
				_G.StartFarm = false
				Level_SD:Set("Stats : Bartilo Quest")
				if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
					for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if v.Name == "Jeremy [Lv. 850] [Boss]" then
							if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
								repeat task.wait()
									PosMon = v.HumanoidRootPart.CFrame
									v.HumanoidRootPart.Size = Vector3.new(60,60,60)
									v.HumanoidRootPart.CanCollide = false
									v.Humanoid.WalkSpeed = 0
									v.Head.CanCollide = false
									BringMobFarm = true
									EquipWeapon(_G.Select_Weapon)
									v.HumanoidRootPart.Transparency = 1
									toposition(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 5))

									if not _G.FastAttack or not _G.FastAttackO or _G.FastAttack or _G.FastAttackO then
										
										
									end
								until not _G.Auto_Bartilo_Quest or not v.Parent or v.Humanoid.Health <= 0 or QuestC.Visible == false or not v:FindFirstChild("HumanoidRootPart")
							end
						end
					end
				else
					toposition(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
					if not game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") and (CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
						if not game:GetService("Workspace").Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
							_G.StartFarm = true
							_G.Auto_Bartilo_Quest = false
						end
					end
				end
			elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
				_G.StartFarm = false
				Level_SD:Set("Stats : Bartilo Quest")
				repeat wait() toposition(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456)) until (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1 or _G.Auto_Bartilo_Quest == false
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
				wait(0.7)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
				wait(0.7)
				_G.StartFarm = true
				wait(2.5) 
				_G.Auto_Bartilo_Quest = false
				_G.Grab_Fruit = true
				
			end
		end
	end)
end
end)
function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then 
			return true
		end
		return false
	end
end
spawn(function()
	while true do wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.Bring_Mob and _G.Start_Kaitun and BringMobFarm then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 500 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMon
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.Size = Vector3.new(60,60,60)
							v.HumanoidRootPart.Transparency = 1
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid:ChangeState(14)
							sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
						end
					end
				end
			end
		end)
	end
end)
spawn(function()
	while wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.Bring_Mob then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if v.Name == QuestCheck()[3] and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 250 then
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
						v.HumanoidRootPart.CFrame = PosMon
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						v.HumanoidRootPart.Size = Vector3.new(60,60,60)
						v.HumanoidRootPart.Transparency = 1
						v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						v.Humanoid:ChangeState(11)
						v.Humanoid:ChangeState(14)
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
					end
				end
			end
		end)
	end
end)
spawn(function()
	while wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.Bring_Mob and BringMobFarm55 then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if v.Name ==  "God's Guard [Lv. 450]" and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 250 then
						v.HumanoidRootPart.CFrame = PosMon
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						v.HumanoidRootPart.Size = Vector3.new(60,60,60)
						v.HumanoidRootPart.Transparency = 1
						v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						v.Humanoid:ChangeState(11)
						v.Humanoid:ChangeState(14)
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
					end
				end
			end
		end)
	end
end)
spawn(function()
	while wait() do
		pcall(function()
			if _G.Start_Kaitun and _G.Bring_Mob and BringMobFarm556 then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if (v.Name == "Snow Lurker [Lv. 1375]" or v.Name == "Arctic Warrior [Lv. 1350]") and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 250 then
						v.HumanoidRootPart.CFrame = PosMon
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						v.HumanoidRootPart.Size = Vector3.new(60,60,60)
						v.HumanoidRootPart.Transparency = 1
						v.HumanoidRootPart.CanCollide = false
						v.Head.CanCollide = false
						if v.Humanoid:FindFirstChild("Animator") then
							v.Humanoid.Animator:Destroy()
						end
						v.Humanoid:ChangeState(11)
						v.Humanoid:ChangeState(14)
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
					end
				end
			end
		end)
	end
end)
spawn(function()
	while wait() do
		_G.Bring_Mob = false
		wait(0.5)
		_G.Bring_Mob = true
		wait(1.5)
	end
end)
_G.FastAttack = true
spawn(function()
	while wait() do
		if _G.Start_Kaitun then
			if game.Players.LocalPlayer.Data.Stats.Melee.Level.Value <= 2449 then
				local args = {
					[1] = "AddPoint",
					[2] = "Melee",
					[3] = 100
				}
				
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
			elseif game.Players.LocalPlayer.Data.Stats.Defense.Level.Value <= 2449 and game.Players.LocalPlayer.Data.Stats.Melee.Level.Value >= 2450 then
				local args = {
					[1] = "AddPoint",
					[2] = "Defense",
					[3] = 100
				}
				
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
			elseif game.Players.LocalPlayer.Data.Stats.Sword.Level.Value <= 2449 and game.Players.LocalPlayer.Data.Stats.Defense.Level.Value >= 2450 then
				local args = {
					[1] = "AddPoint",
					[2] = "Sword",
					[3] = 100
				}
				
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
			end
		end
	end
end)

spawn(function()
	while wait() do
		if _G.Auto_Buy_Devil_Fruit then
			pcall(function()
				for i,v in next,_G.Settings.Main["Select Fruit"] do
					if not game:GetService("Players").LocalPlayer.Data.DevilFruit.Value == v then
						game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("PurchaseRawFruit", v);
					end
				end
			end)
		end                              
	end
end)

local Time = 0.09
local AttackRandom = 2
spawn(function()
	while wait(5.5) do
		AttackRandom = math.random(1,4)
	end
end)
spawn(function()
	while _G.FastAttack do task.wait()
	
	require(game.ReplicatedStorage.Util.CameraShaker):Stop()
	xShadowFastAttackx = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	xShadowx = debug.getupvalues(xShadowFastAttackx)[2]
	task.spawn(function()
		while true do task.wait()
			if _G.FastAttack then
				if typeof(xShadowx) == "table" then
					pcall(function()
						xShadowx.activeController.timeToNextAttack = -(math.huge^math.huge^math.huge)
						xShadowx.activeController.timeToNextAttack = 0
						xShadowx.activeController.hitboxMagnitude = 200
						xShadowx.activeController.active = false
						xShadowx.activeController.timeToNextBlock = 0
						xShadowx.activeController.focusStart = 0
						xShadowx.activeController.increment = 4
						xShadowx.activeController.blocking = false
						xShadowx.activeController.attacking = false
						xShadowx.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end
	end)
	
	function Click()
		local Module = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework)
		local CombatFramework = debug.getupvalues(Module)[2]
		local CamShake = require(game.ReplicatedStorage.Util.CameraShaker)
		CamShake:Stop()
		CombatFramework.activeController.attacking = false
		CombatFramework.activeController.timeToNextAttack = 0
		CombatFramework.activeController.hitboxMagnitude = 180
		game:GetService'VirtualUser':CaptureController()
		game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
	end
	
	
	local SeraphFrame = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework")))[2]
	local VirtualUser = game:GetService('VirtualUser')
	local RigControllerR = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.RigController))[2]
	local Client = game:GetService("Players").LocalPlayer
	
	function SeraphFuckWeapon()
		local p13 = SeraphFrame.activeController
		local wea = p13.blades[1]
		if not wea then return end
		while wea.Parent~=game.Players.LocalPlayer.Character do wea=wea.Parent end
		return wea
	end

	function getHits(Size)
		local Hits = {}
		local Enemies = workspace.Enemies:GetChildren()
		local Characters = workspace.Characters:GetChildren()
		for i=1,#Enemies do local v = Enemies[i]
			local Human = v:FindFirstChildOfClass("Humanoid")
			if Human and Human.RootPart and Human.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size+55 then
				table.insert(Hits,Human.RootPart)
			end
		end
		for i=1,#Characters do local v = Characters[i]
			if v ~= game.Players.LocalPlayer.Character then
				local Human = v:FindFirstChildOfClass("Humanoid")
				if Human and Human.RootPart and Human.Health > 0 and game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size+55 then
					table.insert(Hits,Human.RootPart)
				end
			end
		end
		return Hits
	end
	
	task.spawn(
		function()
		while true do task.wait()
			if  _G.FastAttack then
				if SeraphFrame.activeController then
					SeraphFrame.activeController.timeToNextAttack = -(math.huge^math.huge^math.huge)
					SeraphFrame.activeController.timeToNextAttack = 0
					SeraphFrame.activeController.focusStart = 0
					SeraphFrame.activeController.hitboxMagnitude = 110
					SeraphFrame.activeController.humanoid.AutoRotate = true
					SeraphFrame.activeController.increment = 4
				end
			end
		end
	end)
	
	function Boost()
		spawn(function()
			if SeraphFrame.activeController and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
				game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(SeraphFuckWeapon()))
			end
		end)
	end
	
	local cdnormal = 0
	local Animation = Instance.new("Animation")
	local CooldownFastAttack = 0.000000
	Attack = function()
		local ac = SeraphFrame.activeController
		if ac and ac.equipped then
			task.spawn(
				function()
				if tick() - cdnormal > 0 then
					ac:attack()
					cdnormal = tick()
				else
					Animation.AnimationId = ac.anims.basic[2]
					ac.humanoid:LoadAnimation(Animation):Play(0.01, 0.01) --ท่าไม่ทำงานแก้เป็น (1,1)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", getHits(120), 1, "")

					if AttackRandom == 2 then
						debug.setupvalue(ac.attack, 5, 55495)
						debug.setupvalue(ac.attack, 6, 1892665)
						debug.setupvalue(ac.attack, 4, 907772)
						debug.setupvalue(ac.attack, 7, 14) wait(.1)
					end
					if AttackRandom == 1 or AttackRandom == 3 or AttackRandom == 4 then
						wait(0.2)
					elseif AttackRandom == 2 then
						wait(0.09)
					end
				end
				for _,x in pairs(game:GetService("Players"):GetChildren()) do
					for m,y in pairs(workspace.Characters:GetChildren()) do
						if y.Name == x.Name and y.Name ~= game.Players.LocalPlayer.Name then
							if (y.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 60 then
								if m >= 1 then
									wait(0.16)
								else
									wait(0.2)
								end
							end
						end
					end
				end
			end)
		end
	end
	
	b = tick()
	spawn(function()
		while _G.FastAttack do task.wait()
			if _G.FastAttack then
				if b - tick() > 9e9 then
					b = tick()
				end
				local ac = SeraphFrame.activeController
				pcall(function()
					for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v.Humanoid.Health > 0 then
							if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
								Attack()
								wait()
								Boost()
								if _G.SuperFastAttack then
									AttackFunction()
								end
							end
							for _,x in pairs(game:GetService("Players"):GetChildren()) do
								for m,y in pairs(workspace.Characters:GetChildren()) do
									if y.Name == x.Name and y.Name ~= game.Players.LocalPlayer.Name then
										if (y.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 60 then
											if m >= 3 then
												Attack()
												wait()
												Boost()
												if _G.SuperFastAttack then
													AttackFunction()
												end
											else
												Attack()
												wait()
												Boost()
												if _G.SuperFastAttack then
													AttackFunction()
												end
												wait(0.05)
											end
										end
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
	
	k = tick()
	spawn(function()
		while wait() do
			if  _G.FastAttack then
				if k - tick() > 9e9 then
					k = tick()
				end
				pcall(function()
					for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
						if v.Humanoid.Health > 0 then
							if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 50 then
								Attack()
								wait()
								Boost()
							end
							wait(0.2)
						end
					end
				end)
			end
		end
	end)
	
	tjw1 = true
	task.spawn(
		function()
			local a = game.Players.LocalPlayer
			local b = require(a.PlayerScripts.CombatFramework.Particle)
			local c = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
			if not shared.orl then
				shared.orl = c.wrapAttackAnimationAsync
			end
			if not shared.cpc then
				shared.cpc = b.play
			end
			if tjw1 then
				pcall(
					function()
						c.wrapAttackAnimationAsync = function(d, e, f, g, h)
							local i = c.getBladeHits(e, f, g)
							if i then
								b.play = function()
								end
								d:Play(0.01,0.01,0.01)
								h(i)
								b.play = shared.cpc
								wait(0.1)
								d:Stop()
							end
						end
					end
				)
			end
		end
	)
	
	
	local Client = game.Players.LocalPlayer
	local STOP = require(Client.PlayerScripts.CombatFramework.Particle)
	local STOPRL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
	task.spawn(function()
		pcall(function()
			if not shared.orl then
				shared.orl = STOPRL.wrapAttackAnimationAsync
			end
				if not shared.cpc then
					shared.cpc = STOP.play 
				end
				spawn(function()
					require(game.ReplicatedStorage.Util.CameraShaker):Stop()
					game:GetService("RunService").Stepped:Connect(function()
						STOPRL.wrapAttackAnimationAsync = function(a,b,c,d,func)
							local Hits = STOPRL.getBladeHits(b,c,d)
							if Hits then
								if  _G.FastAttack then
									STOP.play = function() end
									a:Play(21,29,30)
									func(Hits)
									STOP.play = shared.cpc
									a:Stop()
								else
									func(Hits)
									STOP.play = shared.cpc
									a:Stop()
								end
							end
						end
					end)
				end)
			end)
		end)
	end
end)
if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw",true) == 1 then
	if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("Electric Claw") or not game:GetService("Players").LocalPlayer.backpack:FindFirstChild("Electric Claw") then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
	end
end
