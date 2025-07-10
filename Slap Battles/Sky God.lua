repeat
    wait()
until game:IsLoaded()
wait(1)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local GeneralAbility = ReplicatedStorage:WaitForChild("GeneralAbility")
local RocketJump = ReplicatedStorage:WaitForChild("RocketJump")

workspace.Sounds.Select.Volume = 0

LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(512, 10, 512))
LocalPlayer.Character.Humanoid.WalkSpeed = 0
LocalPlayer.Character.Humanoid.JumpPower = 0
LocalPlayer.Character.Humanoid.JumpHeight = 0

local Camera = workspace.CurrentCamera
wait()
Camera.CameraType = Enum.CameraType.Scriptable
wait()
Camera.CFrame = CFrame.new(Vector3.new(100, 100, 100))
wait()
Camera.CameraType = Enum.CameraType.Fixed

local Platform = Instance.new("Part", workspace)
Platform.Anchored = true
Platform.Size = Vector3.new(32, 4, 32)
Platform.Position = Vector3.new(512, 0, 512)

local function Equip(Glove)
    for i, v in ipairs(ReplicatedStorage["_NETWORK"]:GetChildren()) do
        if string.match(v.Name, "{") then
            v:FireServer(Glove)
        end
    end
end

local function Load()
local Reset = Instance.new("Tool")
Reset.Name = "Reload"
Reset.RequiresHandle = false
Reset.ToolTip = "Make Your Powers Work Again"
Reset.CanBeDropped = false
Reset.Parent = LocalPlayer.Backpack
Reset.Activated:Connect(function()
    local Ping = LocalPlayer:GetNetworkPing()
    LocalPlayer.Character.Humanoid.Health = 0
    LocalPlayer.CharacterAdded:Wait()
    local HRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
    --task.wait(Ping)
    --RunService.Heartbeat:Wait()
    --RunService.RenderStepped:Wait()
    --ZEUS, FIX CHARACTER LOADING ISSUE AND MY LIFE IS YOURS!!!
    task.wait(1)
    HRP.CFrame = CFrame.new(Vector3.new(512, 10, 512))
    Humanoid.WalkSpeed = 0
    Humanoid.JumpPower = 0
    Humanoid.JumpHeight = 0
    wait()
    Camera.CameraType = Enum.CameraType.Scriptable
    wait()
    Camera.CFrame = CFrame.new(Vector3.new(100, 100, 100))
    wait()
    Camera.CameraType = Enum.CameraType.Fixed
    Load()
end)

local Explosion = Instance.new("Tool")
Explosion.Name = "Explosion"
Explosion.RequiresHandle = false
Explosion.ToolTip = "Divebomb Required"
Explosion.CanBeDropped = false
Explosion.Parent = LocalPlayer.Backpack
Explosion.Activated:Connect(function()
    Equip("hallowjack")
    local Hit = LocalPlayer:GetMouse().Hit.Position
    local args = {
	    {
	    	chargeAlpha = 0,
		rocketJump = true
	    }
    }
    RocketJump:InvokeServer(unpack(args))
    local args = {
	    {
	    	explosionAlpha = 1,
		    explosion = true,
	    	position = vector.create(math.clamp(Hit.X, -1024, 1024), math.clamp(Hit.Y, -20, 120) , math.clamp(Hit.Z, -1024, 1024))
	    }
    }
    RocketJump:InvokeServer(unpack(args))
end)

local Chain = Instance.new("Tool")
Chain.Name = "Chain"
Chain.RequiresHandle = false
Chain.ToolTip = "Bind Required"
Chain.CanBeDropped = false
Chain.Parent = LocalPlayer.Backpack
Chain.Activated:Connect(function()
    Equip("Bind")
    local Hit = LocalPlayer:GetMouse().Hit.Position
    local args = {
    	"default",
	    {
	    	goal = CFrame.new(math.clamp(Hit.X, -1024, 1024), math.clamp(Hit.Y, -20, 120) , math.clamp(Hit.Z, -1024, 1024)),
	    	origin = CFrame.new(Vector3.new(0, 50, 0))
    	}
    }
    GeneralAbility:FireServer(unpack(args))
end)
end

Load()
