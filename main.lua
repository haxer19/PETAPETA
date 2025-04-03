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
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        else
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

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/linemaster2/esp-library/main/library.lua"))();

ESP.Enabled = false
ESP.ShowBox = false
ESP.ShowName = false
ESP.ShowHealth = false
ESP.ShowTracer = false
ESP.ShowDistance = false

Tabs.Visual:Section({ Title = "ESP Settings" })

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

Tabs.Visual:Dropdown({
    Title = "Box Type",
    Values = {"2D", "Corner Box Esp"},
    Value = "Corner Box Esp",
    Callback = function(option)
        ESP.BoxType = option
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

Tabs.Visual:Dropdown({
    Title = "Box Type",
    Values = {"Top", "Middle", "Bottom"},
    Value = "Middle",
    Callback = function(option)
        ESP.TracerPosition = option
    end
})

Tabs.Visual:Toggle({
    Title = "Show Distance",
    Default = false,
    Callback = function(state)
        ESP.ShowDistance = state
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