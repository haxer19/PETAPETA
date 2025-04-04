local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "PETAPETA",
    Icon = "rbxassetid://139030006778308",
    Author = "Tien Thanh",
    Folder = "EclipseX_PETAPETA",
    Size = UDim2.fromOffset(580, 460),
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

Tabs.Main:Section({ Title = "Part Esp" })
Tabs.Main:Paragraph({
    Title = "Enemy",
    Image = "rbxassetid://7733770982",
    Buttons = {
        {
            Title = "Executor",
            Callback = function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/Enemy"))()
                WindUI:Notify({
                    Title = "Enemy",
                    Content = "Success!!",
                    Duration = 5,
                })
            end
        }
    }
})
Tabs.Main:Section({ Title = " ", TextXAlignment = "Center" })
Tabs.Main:Toggle({
    Title = "Fullbright",
    Default = true,
    Callback = function(state)
        local Lighting = game:GetService("Lighting")
        if state then
            Lighting.Brightness = 1
            Lighting.ClockTime = 12
            Lighting.FogEnd = 10000
            Lighting.GlobalShadows = true
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
        end
    end
})

Tabs.Main:Toggle({
    Title = "NoClip",
    Default = false, 
    Callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart")
        local humanoid = character:WaitForChild("Humanoid")
        if state then
            local noclip = Instance.new("BoolValue")
            noclip.Name = "NoClip"
            noclip.Value = true
            noclip.Parent = character
            
            local function onNoclip()
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            local connection
            connection = game:GetService("RunService").Stepped:Connect(function()
                if not character:FindFirstChild("NoClip") then
                    connection:Disconnect()
                    return
                end
                onNoclip()
            end)
        else
            if character:FindFirstChild("NoClip") then
                character.NoClip:Destroy()
            end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
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

Tabs.Main:Section({ Title = "Level 1 Functions" })

Tabs.Main:Button({
    Title = "Get Key and Ofuda",
    Desc = "Collects key and uses it to get Ofuda",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        local Box = workspace.Server.SpawnedItems.OfudaBox2.OfudaPoint
        local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
        local Backpack = game:GetService("Players").LocalPlayer.Backpack
        local Items = workspace.Server.SpawnedItems
        local Key = Items:FindFirstChild("Key")
        
        if Key:FindFirstChild("InteractPoint") then
            Humanoid.CFrame = Key.WorldPivot
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.Key.InteractPoint.ItemInteractP)
            task.wait(0.3)
        end
        
        if Backpack:FindFirstChild("Key") then
            Humanoid.CFrame = Box.CFrame
            task.wait(0.3)
            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
            task.wait(0.5)
            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
            Humanoid.CFrame = CFrame.new(560.903931, 39.1999626, 602.641663, 0.999947727, 8.53170786e-05, -0.0102250045, 3.32571208e-16, 0.999965191, 0.00834367424, 0.0102253603, -0.00834323838, 0.999912918)
            task.wait(0.3)
            game:GetService("ReplicatedStorage").ItemHandler.OfudaRequest:FireServer(CFrame.new(518.0667724609375, 41.32714080810547, 609.953125) * CFrame.Angles(2.7852535247802734, 0.13421067595481873, -3.0918264389038086))
        end
    end
})

Tabs.Main:Button({
    Title = "Use Key for Ofuda",
    Desc = "Uses existing key to get Ofuda",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        local Box = workspace.Server.SpawnedItems.OfudaBox2.OfudaPoint
        local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
        local Backpack = game:GetService("Players").LocalPlayer.Backpack
        local Items = workspace.Server.SpawnedItems
        
        if Backpack:FindFirstChild("Key") then
            Humanoid.CFrame = Box.CFrame
            task.wait(0.3)
            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
            task.wait(0.5)
            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
        end
    end
})

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))();

ESP.Enabled = false
ESP.ShowBox = false
ESP.ShowName = false
ESP.ShowHealth = false
ESP.ShowTracer = false
ESP.ShowDistance = false

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
    Value = "2D",
    Callback = function(option)
        ESP.BoxType = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Box Type",
    Values = {"Top", "Middle", "Bottom"},
    Value = "Bottom",
    Callback = function(option)
        ESP.TracerPosition = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Box Outline Color",
    Values = {
        ["Black"] = Color3.new(0, 0, 0),
        ["White"] = Color3.new(1, 1, 1),
        ["Red"] = Color3.new(1, 0, 0),
        ["Blue"] = Color3.new(0, 0, 1)
    },
    Value = "",
    Callback = function(option)
        ESP.BoxOutlineColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Box Color",
    Values = {
        ["White"] = Color3.new(1, 1, 1),
        ["Red"] = Color3.new(1, 0, 0),
        ["Green"] = Color3.new(0, 1, 0),
        ["Blue"] = Color3.new(0, 0, 1)
    },
    Value = "",
    Callback = function(option)
        ESP.BoxColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Name Color",
    Values = {
        ["White"] = Color3.new(1, 1, 1),
        ["Yellow"] = Color3.new(1, 1, 0),
        ["Cyan"] = Color3.new(0, 1, 1),
        ["Pink"] = Color3.new(1, 0, 1)
    },
    Value = "",
    Callback = function(option)
        ESP.NameColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Health Outline Color",
    Values = {
        ["Black"] = Color3.new(0, 0, 0),
        ["White"] = Color3.new(1, 1, 1),
        ["Gray"] = Color3.new(0.5, 0.5, 0.5)
    },
    Value = "",
    Callback = function(option)
        ESP.HealthOutlineColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Health High Color",
    Values = {
        ["Green"] = Color3.new(0, 1, 0),
        ["Lime"] = Color3.new(0.5, 1, 0),
        ["Cyan"] = Color3.new(0, 1, 1)
    },
    Value = "",
    Callback = function(option)
        ESP.HealthHighColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Health Low Color",
    Values = {
        ["Red"] = Color3.new(1, 0, 0),
        ["Orange"] = Color3.new(1, 0.5, 0),
        ["Yellow"] = Color3.new(1, 1, 0)
    },
    Value = "",
    Callback = function(option)
        ESP.HealthLowColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Tracer Color",
    Values = {
        ["White"] = Color3.new(1, 1, 1),
        ["Red"] = Color3.new(1, 0, 0),
        ["Blue"] = Color3.new(0, 0, 1),
        ["Purple"] = Color3.new(0.5, 0, 1)
    },
    Value = "",
    Callback = function(option)
        ESP.TracerColor = option
    end
})

Tabs.Visual:Dropdown({
    Title = "Skeletons Color",
    Values = {
        ["White"] = Color3.new(1, 1, 1),
        ["Gray"] = Color3.new(0.5, 0.5, 0.5),
        ["Green"] = Color3.new(0, 1, 0),
        ["Blue"] = Color3.new(0, 0, 1)
    },
    Value = "",
    Callback = function(option)
        ESP.SkeletonsColor = option
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