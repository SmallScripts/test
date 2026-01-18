import React, { useState } from 'react';
import { Lock, Unlock } from 'lucide-react';

export default function HyperHub() {
  const [isUnlocked, setIsUnlocked] = useState(false);
  const [keyInput, setKeyInput] = useState('');
  const [error, setError] = useState('');
  
  const VALID_KEY = 'hhufe37fbkjhbseu2';
  
  // Combat settings
  const [speedBoost, setSpeedBoost] = useState(false);
  const [antiRagdoll, setAntiRagdoll] = useState(true);
  const [hitWhileSneaking, setHitWhileSneaking] = useState(true);
  const [hitRadius, setHitRadius] = useState(10);
  const [spinBot, setSpinBot] = useState(false);
  const [spinSpeed, setSpinSpeed] = useState(45);
  const [autoSteal, setAutoSteal] = useState(false);
  const [unwalkNoAnims, setUnwalkNoAnims] = useState(true);
  const [optimizerXray, setOptimizerXray] = useState(true);
  
  // Movement settings
  const [galaxyMode, setGalaxyMode] = useState(true);
  const [gravity, setGravity] = useState(48);
  const [hipPower, s

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "Rainbowgui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame
local main = Instance.new("Frame")
main.Size = UDim2.fromScale(0.4, 0.5)
main.Position = UDim2.fromScale(0.3, 0.25)
main.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
main.BorderSizePixel = 0
main.Parent = gui

-- Corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = main

-- Title
local title = Instance.new("Hyper Hub")
title.Size = UDim2.fromScale(1, 0.1)
title.BackgroundTransparency = 1
title.Text = "Hyper Hub"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main
