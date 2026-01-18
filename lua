-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "HyperHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Rainbow color function
local function getRainbowColor(timeOffset)
    local t = tick() + timeOffset
    local r = math.sin(t*2)*0.5 + 0.5
    local g = math.sin(t*2 + 2)*0.5 + 0.5
    local b = math.sin(t*2 + 4)*0.5 + 0.5
    return Color3.new(r, g, b)
end

-- Main frame
local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.45, 0.6)
main.Position = UDim2.fromScale(0.3, 0.2)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Parent = gui

-- Draggable
local dragging = false
local dragInput, mousePos, framePos

local function update(input)
    local delta = input.Position - mousePos
    main.Position = UDim2.new(
        math.clamp(framePos.X.Scale + delta.X/GuiService:GetScreenResolution().X, 0, 1),
        framePos.X.Offset + delta.X,
        math.clamp(framePos.Y.Scale + delta.Y/GuiService:GetScreenResolution().Y, 0, 1),
        framePos.Y.Offset + delta.Y
    )
end

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = main

-- Rainbow border
local border = Instance.new("UIStroke")
border.Thickness = 3
border.Parent = main

RunService.RenderStepped:Connect(function()
    border.Color = getRainbowColor(0)
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1, 0.1)
title.Position = UDim2.fromScale(0, 0)
title.BackgroundTransparency = 1
title.Text = "Hyper Hub"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromScale(0.08,0.08)
closeBtn.Position = UDim2.fromScale(0.92,0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = main

closeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    hhButton.Visible = true
end)

-- Small HH Hub button
local hhButton = Instance.new("TextButton")
hhButton.Size = UDim2.fromScale(0.1,0.05)
hhButton.Position = UDim2.fromScale(0,0)
hhButton.Text = "HH Hub"
hhButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
hhButton.TextColor3 = Color3.new(1,1,1)
hhButton.Font = Enum.Font.GothamBold
hhButton.TextScaled = true
hhButton.Visible = false
hhButton.Parent = gui

hhButton.MouseButton1Click:Connect(function()
    main.Visible = true
    hhButton.Visible = false
end)

-- Function to create sliders
local function createSlider(text, position, min, max, default, callback)
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(0.8, 0.05)
    label.Position = position
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.new(1,1,1)
    label.Text = text .. ": " .. default
    label.Parent = main

    -- Slider frame
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.fromScale(0.8, 0.05)
    sliderFrame.Position = position + UDim2.fromScale(0,0.06)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    sliderFrame.Parent = main

    local sliderBorder = Instance.new("UIStroke")
    sliderBorder.Thickness = 2
    sliderBorder.Parent = sliderFrame

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.fromScale((default - min)/(max - min),1)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0,255,0)
    sliderFill.Parent = sliderFrame

    local draggingSlider = false

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
        end
    end)

    sliderFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local relativeX = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
            local value = math.floor((relativeX / sliderFrame.AbsoluteSize.X) * (max - min) + min)
            sliderFill.Size = UDim2.fromScale((value - min)/(max - min), 1)
            label.Text = text .. ": " .. value
            callback(value)
        end
    end)

    -- Rainbow border for slider
    RunService.RenderStepped:Connect(function()
        sliderBorder.Color = getRainbowColor(position.Y.Scale*10)
    end)
end

-- Create all sliders
createSlider("Speed Boost", UDim2.fromScale(0.1,0.15), 0, 100, 48, function(value) print("Speed Boost:", value) end)
createSlider("Spin (Helicopter)", UDim2.fromScale(0.1,0.3), 0, 360, 45, function(value) print("Spin:", value) end)
createSlider("Auto Steal", UDim2.fromScale(0.1,0.45), 0, 100, 0, function(value) print("Auto Steal:", value) end)
createSlider("Hit Radius", UDim2.fromScale(0.1,0.6), 0, 50, 10, function(value) print("Hit Radius:", value) end)
