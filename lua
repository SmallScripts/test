-- Hyper Hub | Auto Execute | No Key

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- Prevent duplicate execution
if game.CoreGui:FindFirstChild("HyperHub") then
	game.CoreGui.HyperHub:Destroy()
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "HyperHub"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- RGB
local function rainbow()
	return Color3.fromHSV((tick() % 6) / 6, 1, 1)
end

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.38, 0.6)
main.Position = UDim2.fromScale(0.31, 0.2)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3

RunService.RenderStepped:Connect(function()
	stroke.Color = rainbow()
end)

-- Drag (touch + mouse)
local dragging, dragStart, startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1, 0.08)
title.BackgroundTransparency = 1
title.Text = "Hyper Hub | PvP"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,140)
title.Parent = main

-- Close (no keybind, just button)
local close = Instance.new("TextButton")
close.Size = UDim2.fromScale(0.08,0.08)
close.Position = UDim2.fromScale(0.92,0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextScaled = true
close.TextColor3 = Color3.fromRGB(255,80,80)
close.BackgroundTransparency = 1
close.Parent = main

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Section
local function section(text, y)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.fromScale(0.9,0.05)
	lbl.Position = UDim2.fromScale(0.05,y)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.Font = Enum.Font.GothamBold
	lbl.TextScaled = true
	lbl.TextColor3 = Color3.fromRGB(200,200,200)
	lbl.Parent = main
end

-- Toggle
local function toggle(text, y)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.fromScale(0.9,0.07)
	frame.Position = UDim2.fromScale(0.05,y)
	frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
	frame.Parent = main
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

	local stroke = Instance.new("UIStroke", frame)
	stroke.Thickness = 2

	RunService.RenderStepped:Connect(function()
		stroke.Color = rainbow()
	end)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(0.7,1)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextScaled = true
	label.TextColor3 = Color3.new(1,1,1)
	label.Parent = frame

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromScale(0.2,0.6)
	btn.Position = UDim2.fromScale(0.75,0.2)
	btn.Text = ""
	btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	btn.Parent = frame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)

	local enabled = false
	btn.MouseButton1Click:Connect(function()
		enabled = not enabled
		btn.BackgroundColor3 = enabled and Color3.fromRGB(255,215,0) or Color3.fromRGB(60,60,60)
	end)
end

-- Slider (visual)
local function slider(text, y)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.fromScale(0.9,0.05)
	label.Position = UDim2.fromScale(0.05,y)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.Gotham
	label.TextScaled = true
	label.TextColor3 = Color3.new(1,1,1)
	label.Parent = main

	local bar = Instance.new("Frame")
	bar.Size = UDim2.fromScale(0.9,0.03)
	bar.Position = UDim2.fromScale(0.05,y+0.05)
	bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	bar.Parent = main
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.fromScale(0.4,1)
	fill.BackgroundColor3 = Color3.fromRGB(255,215,0)
	fill.Parent = bar
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)
end

-- Build UI
section("MOVEMENT", 0.1)
toggle("Speed / Booster", 0.16)
toggle("Anti Ragdoll", 0.24)
slider("Move Speed", 0.32)
slider("Air Speed", 0.40)

section("COMBAT", 0.5)
toggle("Hitbox Expander", 0.56)
toggle("Auto Steal", 0.64)
slider("Bat Range", 0.72)
