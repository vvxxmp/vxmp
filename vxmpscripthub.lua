local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local CORRECT_KEY = "VXMPonTop1"

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VXMP_System"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 1000
screenGui.Parent = playerGui

----------------------------------------------------------------
-- MAIN HUB FUNCTION (Wrapped to trigger after key)
----------------------------------------------------------------
local function LoadMainHub()
    -- Main Container
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Size = UDim2.new(0, 0, 0, 0) -- Starts small for animation
    mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainFrame

    local outerStroke = Instance.new("UIStroke")
    outerStroke.Color = Color3.fromRGB(88, 101, 242)
    outerStroke.Thickness = 1
    outerStroke.Transparency = 0.7
    outerStroke.Parent = mainFrame

    -- Header Bar
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 48)
    header.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
    header.BorderSizePixel = 0
    header.Parent = mainFrame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 10)
    headerCorner.Parent = header

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

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
    closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
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
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.Parent = mainFrame

    -- Dragging Logic
    local dragging, dragInput, dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    -- Scripts Data
    local buttonsData = {
        {name = "Dex Explorer", text = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Dexploits/DexHub/main/Dex%20Hub.lua"))()', subtitle = "Universal"},
        {name = "VAPE Universal Aimbot", text = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/LyxOnlyEu/VAPE/main/vape_public.lua"))()', subtitle = "Universal"}
    }

    local yPos = 0
    for i, data in ipairs(buttonsData) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -12, 0, 52)
        btn.Position = UDim2.new(0, 6, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        btn.Text = ""
        btn.Parent = content
        
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        local s = Instance.new("UIStroke", btn)
        s.Color = Color3.fromRGB(45, 45, 50)

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, -80, 0.6, 0)
        nameLabel.Position = UDim2.new(0, 12, 0, 4)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = data.name
        nameLabel.TextColor3 = Color3.fromRGB(235, 235, 240)
        nameLabel.Font = Enum.Font.GothamSemibold
        nameLabel.TextXAlignment = "Left"
        nameLabel.Parent = btn

        local copyBtn = Instance.new("TextButton")
        copyBtn.Size = UDim2.new(0, 64, 0, 32)
        copyBtn.Position = UDim2.new(1, -72, 0.5, -16)
        copyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        copyBtn.Text = "COPY"
        copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.Parent = btn
        Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

        copyBtn.Activated:Connect(function()
            setclipboard(data.text)
            copyBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
            task.wait(0.4)
            copyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        end)

        yPos = yPos + 60
    end
    content.CanvasSize = UDim2.new(0, 0, 0, yPos)

    closeBtn.Activated:Connect(function()
        screenGui:Destroy()
    end)

    TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 520, 0, 380)}):Play()
end

----------------------------------------------------------------
-- KEY SYSTEM UI
----------------------------------------------------------------
local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
keyFrame.Size = UDim2.new(0, 300, 0, 180)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = screenGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyFrame

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(88, 101, 242)
keyStroke.Thickness = 2
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "VXMP KEY SYSTEM"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 14
keyTitle.Parent = keyFrame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0, 35)
textBox.Position = UDim2.new(0.1, 0, 0.35, 0)
textBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
textBox.Text = ""
textBox.PlaceholderText = "Enter Key Here..."
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Font = Enum.Font.Gotham
textBox.Parent = keyFrame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 35)
submitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
submitBtn.Text = "SUBMIT"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Parent = keyFrame
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 6)

-- Key Logic
submitBtn.Activated:Connect(function()
    if textBox.Text == CORRECT_KEY then
        submitBtn.Text = "SUCCESS!"
        submitBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 80)
        task.wait(0.5)
        
        -- Fade out key UI
        local t = TweenService:Create(keyFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
        t:Play()
        keyFrame:Destroy()
        
        -- Load Hub
        LoadMainHub()
    else
        submitBtn.Text = "INVALID KEY"
        submitBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        task.wait(1)
        submitBtn.Text = "SUBMIT"
        submitBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end
end)
