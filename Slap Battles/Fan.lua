repeat
    wait()
until game:IsLoaded()
wait(0.5)

local RunService = game:GetService("RunService")
local Glove = game:GetService("Players").LocalPlayer.leaderstats.Glove
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility")

while task.wait(0.1) do
    if Glove.Value == "Fan" then
        Remote:FireServer()
    end
    RunService.RenderStepped:Wait()
end
