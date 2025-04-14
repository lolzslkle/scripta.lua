-- ✈️ Fly Script by Kirito
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local flying = false
local up = false
local down = false
local speed = 50

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.P = 9e4
bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
bodyGyro.CFrame = hrp.CFrame

local bodyVel = Instance.new("BodyVelocity")
bodyVel.Velocity = Vector3.new(0, 0, 0)
bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

local function startFlying()
	bodyGyro.Parent = hrp
	bodyVel.Parent = hrp
end

local function stopFlying()
	bodyGyro.Parent = nil
	bodyVel.Parent = nil
end

uis.InputBegan:Connect(function(input, processed)
	if processed then return end

	if input.KeyCode == Enum.KeyCode.F then
		flying = not flying
		if flying then
			startFlying()
		else
			stopFlying()
		end
	elseif input.KeyCode == Enum.KeyCode.E then
		up = true
	elseif input.KeyCode == Enum.KeyCode.Q then
		down = true
	end
end)

uis.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.E then
		up = false
	elseif input.KeyCode == Enum.KeyCode.Q then
		down = false
	end
end)

rs.RenderStepped:Connect(function()
	if flying then
		local cam = workspace.CurrentCamera
		bodyGyro.CFrame = cam.CFrame

		local vel = Vector3.zero
		if up then vel = vel + Vector3.new(0, speed, 0) end
		if down then vel = vel - Vector3.new(0, speed, 0) end

		bodyVel.Velocity = cam.CFrame.LookVector * 0 + vel
	end
end)
