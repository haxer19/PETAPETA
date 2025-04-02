local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "PETAPETA",
    Icon = "rbxassetid://139030006778308",
    Author = "Tien Thanh",
    Folder = "EclipseX_PETAPETA",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
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
}

Window:SelectTab(1)

Tabs.User:Section({ Title = "Part Esp" })
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
