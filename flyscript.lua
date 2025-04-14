local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

for _, player in pairs(Players:GetPlayers()) do
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart

        -- สร้างเสียงระเบิด
        local sound = Instance.new("Sound", rootPart)
        sound.SoundId = "rbxassetid://138186576" -- เสียงระเบิด
        sound.Volume = 1
        sound:Play()
        Debris:AddItem(sound, 3)

        -- สร้างเอฟเฟกระเบิด
        local explosion = Instance.new("Explosion")
        explosion.Position = rootPart.Position
        explosion.BlastRadius = 0 -- เพื่อไม่ให้ดาเมจจริง
        explosion.BlastPressure = 0
        explosion.Parent = workspace

        -- Reset
        player:LoadCharacter()
    end
end
