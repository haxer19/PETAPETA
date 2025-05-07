loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/PETAPETA/main/Enemy"))()
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "PETAPETA",
    Icon = "rbxassetid://139030006778308",
    Author = "Tien Thanh",
    Folder = "EclipseX_PETAPETA",
    Size = UDim2.fromOffset(540, 340) ,
    Transparent = true,
    Theme = "Dark",
    ToggleKey = Enum.KeyCode.LeftControl,
    SideBarWidth = 200,
    HasOutline = false
})

Window:EditOpenButton({
    Title = "O",
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
}

Window:SelectTab(1)

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

Tabs.Main:Section({ Title = "Level 1" })
Tabs.Main:Button({
    Title = "Activate",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        local Box = workspace.Server.SpawnedItems.OfudaBox2.OfudaPoint
        local Humanoid = game.Players.LocalPlayer.Character.HumanoidRootPart
        local Backpack = game:GetService("Players").LocalPlayer.Backpack
        local Items = workspace.Server.SpawnedItems
        local Key = Items:FindFirstChild("Key")
        if Key and Key:FindFirstChild("InteractPoint") then
            Humanoid.CFrame = Key.WorldPivot
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.Key.InteractPoint.ItemInteractP)
            task.wait(0.3)
        end
        
        if Backpack:WaitForChild("Key", 5) then
            Humanoid.CFrame = Box.CFrame
            task.wait(0.3)
            Character.Humanoid:EquipTool(Backpack:WaitForChild("Key"))
            task.wait(0.3)
            fireproximityprompt(workspace.Server.SpawnedItems.OfudaBox2.InteractPoint.ItemInteractP)
            task.wait(0.5)
            fireproximityprompt(workspace.Server.SpawnedItems.Ofuda.Handle.ItemInteractP)
            Humanoid.CFrame = CFrame.new(560.903931, 39.1999626, 602.641663, 0.999947727, 8.53170786e-05, -0.0102250045, 3.32571208e-16, 0.999965191, 0.00834367424, 0.0102253603, -0.00834323838, 0.999912918)
            task.wait(0.3)
            game:GetService("ReplicatedStorage").ItemHandler.OfudaRequest:FireServer(
                CFrame.new(518.0667724609375, 41.32714080810547, 609.953125) * 
                CFrame.Angles(2.7852535247802734, 0.13421067595481873, -3.0918264389038086)
            )
        end
    end
})

Tabs.Main:Section({ Title = "Level 2" })

Tabs.Main:Button({
    Title = "Activate",
    Callback = function()
    end
})

Tabs.Main:Section({ Title = "Level 3" })
Tabs.Main:Button({
    Title = "Activate",
    Callback = function()
    end
})

Tabs.Main:Section({ Title = "Level 4" })
Tabs.Main:Button({
    Title = "Activate",
    Callback = function()
    end
})

Tabs.Main:Section({ Title = "Level 5" })
Tabs.Main:Button({
    Title = "Activate",
    Callback = function()
    end
})

Tabs.Main:Section({ Title = "Level 6" })
Tabs.Main:Button({
    Title = "Activate",
    Callback = function()
    end
})