local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local flying = false
local flySpeed = 50
local flyUp = false
local flyDown = false

local function startFly()
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local root = char.HumanoidRootPart
	local bv = Instance.new("BodyVelocity")
	bv.Name = "FlyVelocity"
	bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	bv.Velocity = Vector3.zero
	bv.Parent = root

	local bg = Instance.new("BodyGyro")
	bg.Name = "FlyGyro"
	bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	bg.CFrame = root.CFrame
	bg.P = 10000
	bg.Parent = root

	RunService.RenderStepped:Connect(function()
		if flying and root:FindFirstChild("FlyVelocity") then
			local cam = workspace.CurrentCamera
			local dir = Vector3.new(0, 0, 0)
			if flyUp then dir += Vector3.new(0, 1, 0) end
			if flyDown then dir += Vector3.new(0, -1, 0) end

			bv.Velocity = cam.CFrame:VectorToWorldSpace(dir.Unit) * flySpeed
			bg.CFrame = cam.CFrame
		end
	end)
end

local function stopFly()
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local root = char.HumanoidRootPart
	if root:FindFirstChild("FlyVelocity") then root.FlyVelocity:Destroy() end
	if root:FindFirstChild("FlyGyro") then root.FlyGyro:Destroy() end
end

-- Toggle บิน
local function toggleFly()
	flying = not flying
	if flying then
		startFly()
	else
		stopFly()
	end
end

-- รองรับปุ่มกด (PC)
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.F then
		toggleFly()
	elseif input.KeyCode == Enum.KeyCode.E then
		flyUp = true
	elseif input.KeyCode == Enum.KeyCode.Q then
		flyDown = true
	end
end)

UIS.InputEnded:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.E then
		flyUp = false
	elseif input.KeyCode == Enum.KeyCode.Q then
		flyDown = false
	end
end)

-- รองรับมือถือ: ใช้การกระโดดเพื่อ toggle
player.CharacterAdded:Connect(function(char)
	char:WaitForChild("Humanoid").Jumping:Connect(function(active)
		if active and UIS.TouchEnabled then
			toggleFly()
		end
	end)
end)
