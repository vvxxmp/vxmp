
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EliteCopyHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1000
screenGui.Parent = playerGui

-- Main Container
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 520, 0, 380)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- Subtle outer glow
local outerStroke = Instance.new("UIStroke")
outerStroke.Color = Color3.fromRGB(88, 101, 242)
outerStroke.Thickness = 1
outerStroke.Transparency = 0.7
outerStroke.Parent = mainFrame

-- Header Bar
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = header

local headerStroke = Instance.new("UIStroke")
headerStroke.Color = Color3.fromRGB(88, 101, 242)
headerStroke.Thickness = 1
headerStroke.Transparency = 0.8
headerStroke.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -90, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Text = "VXMP Script Hub"
title.TextColor3 = Color3.fromRGB(230, 230, 235)
title.TextSize = 16
title.Font = Enum.Font.GothamSemibold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Content Area
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -24, 1, -80)
content.Position = UDim2.new(0, 12, 0, 56)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(88, 101, 242)
content.ScrollBarImageTransparency = 0.5
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.Parent = mainFrame

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

header.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Copy function
local function copyToClipboard(text)
    setclipboard(text)
    return true
end

-- Button hover animation
local function animateButton(button, stroke, hover)
    local targetBg = hover and Color3.fromRGB(25, 25, 32) or Color3.fromRGB(20, 20, 25)
    local targetStroke = hover and Color3.fromRGB(88, 101, 242) or Color3.fromRGB(45, 45, 50)
    
    TweenService:Create(button, TweenInfo.new(0.12, Enum.EasingStyle.Quint), {
        BackgroundColor3 = targetBg
    }):Play()
    
    TweenService:Create(stroke, TweenInfo.new(0.12, Enum.EasingStyle.Quint), {
        Color = targetStroke,
        Thickness = hover and 1.5 or 1
    }):Play()
end

-- Close button
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = Color3.fromRGB(220, 60, 60),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.12), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        TextColor3 = Color3.fromRGB(160, 160, 170)
    }):Play()
end)

closeBtn.Activated:Connect(function()
    TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.2)
    screenGui:Destroy()
end)

local buttonsData = {
    {
        name = "Dex Explorer",
        text = "loadstring(game:HttpGet("https://raw.githubusercontent.com/Dexploits/DexHub/main/Dex%20Hub.lua"))()",
        subtitle = "Universal"
    },
    {
        name = "VAPE universal",
        text = "loadstring(game:HttpGet("https://raw.githubusercontent.com/LyxOnlyEu/VAPE/main/vape_public.lua"))()",
        subtitle = "Universal"
    }
}

-- Create buttons
local yPos = 0
for i, data in ipairs(buttonsData) do
    -- Button frame
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -12, 0, 52)
    btn.Position = UDim2.new(0, 6, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.LayoutOrder = i
    btn.Parent = content
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Color3.fromRGB(45, 45, 50)
    btnStroke.Thickness = 1
    btnStroke.Parent = btn
    
    -- Name label
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -80, 0.6, 0)
    nameLabel.Position = UDim2.new(0, 12, 0, 4)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = data.name
    nameLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = btn
    
    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(1, -80, 0.4, 0)
    subtitleLabel.Position = UDim2.new(0, 12, 0.6, 0)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = data.subtitle
    subtitleLabel.TextColor3 = Color3.fromRGB(120, 125, 135)
    subtitleLabel.TextSize = 11
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.Parent = btn
    
    -- Copy button
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 64, 0, 32)
    copyBtn.Position = UDim2.new(1, -72, 0.5, -16)
    copyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    copyBtn.Text = "COPY"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.TextSize = 11
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.BorderSizePixel = 0
    copyBtn.Parent = btn
    
    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 6)
    copyCorner.Parent = copyBtn
    
    btn.MouseEnter:Connect(function() animateButton(btn, btnStroke, true) end)
    btn.MouseLeave:Connect(function() animateButton(btn, btnStroke, false) end)
    
    copyBtn.MouseEnter:Connect(function()
        TweenService:Create(copyBtn, TweenInfo.new(0.12), {
            BackgroundColor3 = Color3.fromRGB(105, 120, 255),
            Size = UDim2.new(0, 70, 0, 36)
        }):Play()
    end)
    
    copyBtn.MouseLeave:Connect(function()
        TweenService:Create(copyBtn, TweenInfo.new(0.12), {
            BackgroundColor3 = Color3.fromRGB(88, 101, 242),
            Size = UDim2.new(0, 64, 0, 32)
        }):Play()
    end)
    
    copyBtn.Activated:Connect(function()
        local success = copyToClipboard(data.text)
        if success then
            TweenService:Create(copyBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 180, 80)
            }):Play()
            
            task.wait(0.4)
            TweenService:Create(copyBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(88, 101, 242)
            }):Play()
        end
    end)
    
    yPos = yPos + 60
end

content.CanvasSize = UDim2.new(0, 0, 0, yPos)

local instructionFrame = Instance.new("Frame")
instructionFrame.Name = "InstructionFrame"
instructionFrame.Size = UDim2.new(1, -24, 0, 24)
instructionFrame.Position = UDim2.new(0, 12, 1, -36)
instructionFrame.BackgroundTransparency = 1
instructionFrame.Parent = mainFrame

local instructionLabel = Instance.new("TextLabel")
instructionLabel.Name = "InstructionLabel"
instructionLabel.Size = UDim2.new(1, 0, 1, 0)
instructionLabel.BackgroundTransparency = 1
instructionLabel.Text = "Click COPY then paste code into your executor"
instructionLabel.TextColor3 = Color3.fromRGB(180, 185, 195)
instructionLabel.TextSize = 11
instructionLabel.Font = Enum.Font.Gotham
instructionLabel.TextXAlignment = Enum.TextXAlignment.Center
instructionLabel.Parent = instructionFrame

-- Subtle fade-in animation for instruction
instructionLabel.TextTransparency = 1
TweenService:Create(instructionLabel, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
    TextTransparency = 0
}):Play()

mainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 520, 0, 380)
}):Play()

print("Elite Copy Hub loaded - Professional design active")
