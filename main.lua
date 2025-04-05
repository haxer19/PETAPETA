loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/Enemy"))()
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

function getopsize()
    local screenSize = workspace.CurrentCamera.ViewportSize
    if screenSize.X <= 720 then
        return UDim2.fromOffset(240, 180) 
    elseif screenSize.X <= 1080 then
        return UDim2.fromOffset(360, 280)
    else
        return UDim2.fromOffset(480, 360) 
    end
end

local Window = WindUI:CreateWindow({
    Title = "PETAPETA",
    Icon = "rbxassetid://139030006778308",
    Author = "Tien Thanh",
    Folder = "EclipseX_PETAPETA",
    Size = getopsize(),
    Transparent = true,
    Theme = "Dark",
    ToggleKey = Enum.KeyCode.LeftControl,
    SideBarWidth = 200,
    HasOutline = false
})

Window:EditOpenButton({
    Title = "Open Menu",
    Icon = "rbxassetid://139030006778308",
    CornerRadius = UDim.new(0, 10),
    StrokeThickness = 2,
    Color = ColorSequence.new( 
        Color3.fromHex("8A2BE2"), 
        Color3.fromHex("6A0DAD") 
    ),
    Draggable = false,
})

WindUI:AddTheme({
    Name = "MysticPurple",
    Accent = "#5A2A7E", 
    Outline = "#3D1E56", 
    Background = "#1E1029", 
    SecondaryBackground = "#2A1840", 
    Text = "#E6DAFA", 
    PlaceholderText = "#A88CC9"
})

WindUI:SetTheme("MysticPurple")

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "rbxassetid://7733960981", Desc = "main" }),
    Visual = Window:Tab({ Title = "Visual", Icon = "rbxassetid://7733774602", Desc = "visual" }),
    Player = Window:Tab({ Title = "Player", Icon = "rbxassetid://7734056608", Desc = "player" }),
}

WindUI:Notify({
    Title = "ESP PETAPETA",
    Content = "Activated !!",
    Duration = 5,
})

-- Tabs.Main:Section({ Title = "Part Esp" })
-- Tabs.Main:Paragraph({
--     Title = "Enemy",
--     Image = "rbxassetid://7733770982",
--     Buttons = {
--         {
--             Title = "Executor",
--             Callback = function()
--                 loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/Enemy"))()
--                 WindUI:Notify({
--                     Title = "Enemy",
--                     Content = "Success!!",
--                     Duration = 5,
--                 })
--             end
--         }
--     }
-- })

Tabs.Main:Section({ Title = " ", TextXAlignment = "Center" })

local fb = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/fb"))()

Tabs.Main:Toggle({
    Title = "Fullbright",
    Default = true,
    Callback = function(state)
        if state then
            fb:Enable() 
        end
    end
})

Tabs.Main:Toggle({
    Title = "NoClip",
    Default = false,
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local function updateNoClip(char, enabled)
            if enabled then
                local noclip = Instance.new("BoolValue")
                noclip.Name = "NoClip"
                noclip.Value = true
                noclip.Parent = char
                
                local connection
                connection = game:GetService("RunService").Stepped:Connect(function()
                    if not char:FindFirstChild("NoClip") then
                        connection:Disconnect()
                        return
                    end
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            else
                if char:FindFirstChild("NoClip") then
                    char.NoClip:Destroy()
                end
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end

        updateNoClip(character, state)

        local connection
        if state then
            connection = player.CharacterAdded:Connect(function(newChar)
                humanoid = newChar:WaitForChild("Humanoid")
                updateNoClip(newChar, true)
            end)
        end
        
        if not state and connection then
            connection:Disconnect()
        end
    end
})

Tabs.Main:Section({ Title = " ", TextXAlignment = "Center" })
Tabs.Main:Button({
    Title = "Collect Money",
    Desc = "Collects all available coins",
    Callback = function()
        local Char = game.Players.LocalPlayer.Character
        local Humanoid = Char.HumanoidRootPart
        local PreP = Instance.new("Part")
        PreP.Position = Humanoid.Position
        PreP.Anchored = true
        PreP.CanCollide = false
        PreP.Transparency = 1
        PreP.Parent = game.Workspace
        PreP.Name = "PreviousPart"
        
        for _, zeni in pairs(workspace.Server.SpawnedItems:GetChildren()) do
            if zeni:FindFirstChild("Meshes/coin") and zeni:FindFirstChild("InteractPoint") then
                Humanoid.CFrame = zeni:WaitForChild("InteractPoint").CFrame
                task.wait(0.5)
                fireproximityprompt(zeni:WaitForChild("InteractPoint"):WaitForChild("ItemInteractP"))
            end
        end
        
        task.wait(0.25)
        Humanoid.CFrame = PreP.CFrame
        task.wait(1)
        game.Workspace.PreviousPart:Destroy()
    end
})

Tabs.Main:Button({
    Title = "Better Camera",
    Desc = "Removes nos from PlayerGui",
    Callback = function()
        game:GetService("Players").LocalPlayer.PlayerGui.nos:Destroy()
    end
})
-- Functions:
local function moveToPosition(humanoidRootPart, targetCFrame, duration)
    local humanoid = humanoidRootPart.Parent:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true 
        local tweenInfo = TweenInfo.new(
            duration,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        humanoid.PlatformStand = false 
    end
end

Tabs.Main:Section({ Title = "Level 1" })

Tabs.Main:Button({
    Title = "Get Key and Ofuda",
    Desc = "",
    Callback = function()
        local Character = game:GetService("Players").LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Backpack = game:GetService("Players").LocalPlayer.Backpack
        local Items = workspace.Server.SpawnedItems
        local Key = Items:FindFirstChild("Key")
        local Box = workspace.Server.SpawnedItems.OfudaBox2.OfudaPoint
        
        if not HumanoidRootPart then return end

        if Key and Key:FindFirstChild("InteractPoint") then
            moveToPosition(HumanoidRootPart, Key.WorldPivot, 2)
            task.wait(0.3)
            fireproximityprompt(Key.InteractPoint.ItemInteractP)
            task.wait(0.3)
        end
        
        if Backpack:FindFirstChild("Key") then
            moveToPosition(HumanoidRootPart, Box.CFrame, 2)
            task.wait(0.3)
            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
            task.wait(0.5)
            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
            
            local finalCFrame = CFrame.new(560.903931, 39.1999626, 602.641663, 0.999947727, 8.53170786e-05, -0.0102250045, 3.32571208e-16, 0.999965191, 0.00834367424, 0.0102253603, -0.00834323838, 0.999912918)
            moveToPosition(HumanoidRootPart, finalCFrame, 2)
            task.wait(0.3)
            game:GetService("ReplicatedStorage").ItemHandler.OfudaRequest:FireServer(
                CFrame.new(518.0667724609375, 41.32714080810547, 609.953125) * 
                CFrame.Angles(2.7852535247802734, 0.13421067595481873, -3.0918264389038086)
            )
            task.wait(0.4)
            moveToPosition(HumanoidRootPart, Box.CFrame, 2)
            task.wait(0.3)
            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
            task.wait(0.5)
            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
        end
    end
})

local function moveToPosition2(humanoidRootPart, targetCFrame, duration)
    local humanoid = humanoidRootPart.Parent:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local tween = game:GetService("TweenService"):Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        humanoid.PlatformStand = false
    end
end

Tabs.Main:Section({ Title = "Level 2" })
Tabs.Main:Button({
    Title = "Hint Paper Finder",
    Desc = "",
    Callback = function()
        local Character = game:GetService("Players").LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Camera = workspace.CurrentCamera
        local Backpack = game:GetService("Players").LocalPlayer.Backpack
        local Box = workspace.Server.SpawnedItems.OfudaBox2.OfudaPoint
        local Key = workspace.Server.MapGenerated.Rooms.Room.Props.Safe.Key
        local Items = workspace.Server.SpawnedItems
        
        if not HumanoidRootPart then return end

        for _, Room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
            if Room:FindFirstChild("HintPaper") then
                moveToPosition2(HumanoidRootPart, Room.HintPaper.CFrame, 2)
                Camera.CameraType = Enum.CameraType.Scriptable
                local cameraTweenInfo = TweenInfo.new(
                    1, 
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out
                )
                local cameraGoal = {
                    CFrame = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 5, 10), Room.HintPaper.Position)
                }
                local cameraTween = game:GetService("TweenService"):Create(Camera, cameraTweenInfo, cameraGoal)
                cameraTween:Play()
                cameraTween.Completed:Wait()
                task.wait(1)
                Camera.CameraType = Enum.CameraType.Custom
                break
            end
        end
        
        task.wait(2)

        for _, Room in pairs(workspace.Server.MapGenerated.Rooms:GetChildren()) do
            if Room:WaitForChild("Props"):FindFirstChild("Safe") then
                local Safe = Room.Props.Safe
                moveToPosition(HumanoidRootPart, Safe.InteractPoint.CFrame, 2)
                task.wait(0.25)
                if Safe:FindFirstChild("InteractPoint") and Safe:FindFirstChild("InteractPoint"):FindFirstChild("focus") then
                    fireproximityprompt(Safe.InteractPoint.focus)
                end
                
                local connection
                connection = Safe.InteractPoint.ChildRemoved:Connect(function(child)
                    if child.Name == "focus" then 
                        connection:Disconnect() 
                        task.wait(1)
                        WindUI:Notify({
                            Title = "NOTI",
                            Content = "Wait 1 sec, key auto-fetched.",
                            Duration = 5,
                        })
                        -- print("Két sắt đã mở")
               
                        if Key and Key:FindFirstChild("InteractPoint") then
                            moveToPosition(HumanoidRootPart, Key.WorldPivot, 2)
                            task.wait(0.3)
                            fireproximityprompt(Key.InteractPoint.ItemInteractP)
                            task.wait(0.3)
                        end
                
                        if Backpack:FindFirstChild("Key") then
                            moveToPosition(HumanoidRootPart, Box.CFrame, 2)
                            task.wait(0.3)
                            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
                            task.wait(0.3)
                            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
                            task.wait(0.5)
                            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
                            
                            local finalCFrame = CFrame.new(560.903931, 39.1999626, 602.641663, 0.999947727, 8.53170786e-05, -0.0102250045, 3.32571208e-16, 0.999965191, 0.00834367424, 0.0102253603, -0.00834323838, 0.999912918)
                            moveToPosition(HumanoidRootPart, finalCFrame, 2)
                            task.wait(0.3)
                            game:GetService("ReplicatedStorage").ItemHandler.OfudaRequest:FireServer(
                                CFrame.new(518.0667724609375, 41.32714080810547, 609.953125) * 
                                CFrame.Angles(2.7852535247802734, 0.13421067595481873, -3.0918264389038086)
                            )
                            task.wait(0.4)
                            moveToPosition(HumanoidRootPart, Box.CFrame, 2)
                            task.wait(0.3)
                            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
                            task.wait(0.3)
                            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
                            task.wait(0.5)
                            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
                            task.wait(0.5)
                            game:GetService("ReplicatedStorage").ItemHandler.OfudaRequest:FireServer(CFrame.new(-122.064453125, 41.4366455078125, 246.3217315673828) * CFrame.Angles(3.0124473571777344, -0.18015220761299133, 3.1183271408081055))
                            task.wait(0.2)
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/afd"))()
                        end
                    -- else
                    --     print("Két sắt chưa mở")
                    end
                end)
                break
            end
        end
    end
})
--[[
task.wait(0.1)
game:GetService("ReplicatedStorage").ItemHandler.OfudaRequest:FireServer(CFrame.new(-122.064453125, 41.4366455078125, 246.3217315673828) * CFrame.Angles(3.0124473571777344, -0.18015220761299133, 3.1183271408081055))
task.wait(0.3)
loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/afd"))()
]]

-- END Functions Level
local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))();

ESP.Enabled = false
ESP.ShowBox = false
ESP.ShowName = false
ESP.ShowHealth = false
ESP.ShowTracer = false
ESP.ShowDistance = false

Tabs.Visual:Section({ Title = " ", TextXAlignment = "Center" })
Tabs.Visual:Paragraph({
    Title = "⚠️ WARNING",
    Desc = "EDIT SETTINGS FIRST AND THEN ENABLE ESP FUNCTION.",
})

Tabs.Visual:Section({ Title = "ESP PLAYER", TextXAlignment = "Center" })

Tabs.Visual:Toggle({
    Title = "Enable ESP",
    Default = false,
    Callback = function(state)
        ESP.Enabled = state
    end
})

Tabs.Visual:Toggle({
    Title = "Show Boxes",
    Default = false,
    Callback = function(state)
        ESP.ShowBox = state
    end
})

Tabs.Visual:Toggle({
    Title = "Show Names",
    Default = false,
    Callback = function(state)
        ESP.ShowName = state
    end
})

Tabs.Visual:Toggle({
    Title = "Show Health",
    Default = false,
    Callback = function(state)
        ESP.ShowHealth = state
    end
})

Tabs.Visual:Toggle({
    Title = "Show Tracers",
    Default = false,
    Callback = function(state)
        ESP.ShowTracer = state
    end
})

Tabs.Visual:Toggle({
    Title = "Show Distance",
    Default = false,
    Callback = function(state)
        ESP.ShowDistance = state
    end
})

Tabs.Visual:Section({ Title = "Settings", TextXAlignment = "Center" })

Tabs.Visual:Dropdown({
    Title = "Box Type",
    Values = {"2D", "Corner Box Esp"},
    Value = "",
    Callback = function(option)
        ESP.BoxType = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Box Type",
    Values = {"Top", "Middle", "Bottom"},
    Value = "",
    Callback = function(option)
        ESP.TracerPosition = option
    end
})

local Colors = {
    ["Black"] = Color3.new(0, 0, 0),
    ["White"] = Color3.new(1, 1, 1),
    ["Red"] = Color3.new(1, 0, 0),
    ["Blue"] = Color3.new(0, 0, 1),
    ["Green"] = Color3.new(0, 1, 0),
    ["Yellow"] = Color3.new(1, 1, 0),
    ["Cyan"] = Color3.new(0, 1, 1),
    ["Pink"] = Color3.new(1, 0, 1),
    ["Gray"] = Color3.new(0.5, 0.5, 0.5),
    ["Lime"] = Color3.new(0.5, 1, 0),
    ["Orange"] = Color3.new(1, 0.5, 0),
    ["Purple"] = Color3.new(0.5, 0, 1),
}

Tabs.Visual:Dropdown({
    Title = "Box Outline Color",
    Values = { "Black", "White", "Red", "Blue" },
    Value = "",
    Callback = function(option)
        ESP.BoxOutlineColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Box Color",
    Values = { "White", "Red", "Green", "Blue" },
    Value = "",
    Callback = function(option)
        ESP.BoxColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Name Color",
    Values = { "White", "Yellow", "Cyan", "Pink" },
    Value = "",
    Callback = function(option)
        ESP.NameColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Health Outline Color",
    Values = { "Black", "White", "Gray" },
    Value = "",
    Callback = function(option)
        ESP.HealthOutlineColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Health High Color",
    Values = { "Green", "Lime", "Cyan" },
    Value = "",
    Callback = function(option)
        ESP.HealthHighColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Health Low Color",
    Values = { "Red", "Orange", "Yellow" },
    Value = "",
    Callback = function(option)
        ESP.HealthLowColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Tracer Color",
    Values = { "White", "Red", "Blue", "Purple" },
    Value = "",
    Callback = function(option)
        ESP.TracerColor = Colors[option]
    end
})

Tabs.Visual:Dropdown({
    Title = "Skeletons Color",
    Values = { "White", "Gray", "Green", "Blue" },
    Value = "",
    Callback = function(option)
        ESP.SkeletonsColor = Colors[option]
    end
})

Tabs.Player:Section({ Title = "Teleport Manager" })

local PList = {}
local SelectP = ""

local function updatePList()
    PList = {}
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            table.insert(PList, player.Name)
        end
    end
    return PList
end

local TP = Tabs.Player:Dropdown({
    Title = "Select Player",
    Values = updatePList(),
    Value = "",
    Callback = function(option)
        SelectP = option
    end
})

Tabs.Player:Button({
    Title = "Teleport",
    Desc = "Teleport to selected player",
    Callback = function()
        if SelectP ~= "" then
            local target = game:GetService("Players"):FindFirstChild(SelectP)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                game:GetService("Players").LocalPlayer.Character:PivotTo(target.Character.HumanoidRootPart.CFrame)
            end
        end
    end
})

Tabs.Player:Button({
    Title = "Refresh List",
    Desc = "Update player list",
    Callback = function()
        TP:Refresh(updatePList())
    end
})