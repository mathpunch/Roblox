repeat
    wait()
until game:IsLoaded()
wait(0.3)

local ConsoleLogging = true

local function Log(Text)
    if ConsoleLogging then
        warn(Text)
    end
end

if getgenv().SpawnPoints == true then
    Log("|Already Executed|")
    return
end

getgenv().SpawnPoints = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlaceId = {1962086868, 94971861814985, 3582763398}
local CurrentSpawnPart = nil

if table.find(PlaceId, game.PlaceId) then
    Log("|Loading Spawn Points|")
else
    return
end

local function AddSpawnPoint(Platform)
    Platform.Touched:Connect(function(Part)
        if Part.Parent.Name == LocalPlayer.Name and CurrentSpawnPart ~= Platform then
            if CurrentSpawnPart ~= nil then
                if Platform.Position.Y > CurrentSpawnPart.Position.Y then
                    CurrentSpawnPart = Platform
                    Log("|New Spawn Point|")
                end
            else
                CurrentSpawnPart = Platform
                Log("|New Spawn Point|")
            end
        end
    end)
end

local function Teleport(Character)
    if CurrentSpawnPart ~= nil then
        Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(CurrentSpawnPart.Position + Vector3.new(0, 2, 0))
    end
end

for i, v in ipairs(workspace:GetDescendants()) do
    if v.Name == "stop" or v.Name == "start" and v:IsA("Part")  then
        AddSpawnPoint(v)
    end
end

workspace.DescendantAdded:Connect(function(Descendant)
    RunService.Heartbeat:Wait()
    if Descendant.Name == "stop" or Descendant.Name == "start" and Descendant:IsA("Part") then
        AddSpawnPoint(Descendant)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(Character)
    local Ping = LocalPlayer:GetNetworkPing()*2
    RunService.Heartbeat:Wait()
    print(task.wait(Ping))
    Teleport(Character)
end)

Log("|Spawn Points Loaded|")
