local _0xA1 = game
local _0xB2 = _0xA1:GetService("Players").LocalPlayer
local _0xC3 = _0xA1:GetService("Workspace")
local _0xD4 = _0xA1:GetService("ReplicatedStorage")
local _0xE5 = Instance.new("ScreenGui")
_0xE5.Parent = _0xB2:WaitForChild("PlayerGui")
_0xE5.ResetOnSpawn = false

local _0xF6 = Instance.new("Frame", _0xE5)
_0xF6.Size = UDim2.new(0, 220, 0, 150)
_0xF6.Position = UDim2.new(0.5, -110, 0.5, -75)
_0xF6.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_0xF6.BorderSizePixel = 0
_0xF6.Active = true
_0xF6.Draggable = true

local _0xG7 = Instance.new("TextLabel", _0xF6)
_0xG7.Size = UDim2.new(1, 0, 0, 30)
_0xG7.Text = "custom"
_0xG7.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
_0xG7.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xG7.Font = Enum.Font.SourceSansBold
_0xG7.TextSize = 18

local function _0xH8()
    return math.random(1, 100) > 50
end

local _0xI9 = false
local _0xJ0 = Instance.new("TextButton", _0xF6)
_0xJ0.Size = UDim2.new(1, -10, 0, 40)
_0xJ0.Position = UDim2.new(0, 5, 0, 35)
_0xJ0.Text = "Plantar Árvores em Círculo: OFF"
_0xJ0.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
_0xJ0.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xJ0.Font = Enum.Font.SourceSans
_0xJ0.TextSize = 16
_0xJ0.MouseButton1Click:Connect(function()
    _0xI9 = not _0xI9
    _0xJ0.Text = "Plantar Árvores em Círculo: " .. (_0xI9 and "ON" or "OFF")
    _0xJ0.BackgroundColor3 = _0xI9 and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
end)

local _0xK1 = false
local _0xL2 = Instance.new("TextButton", _0xF6)
_0xL2.Size = UDim2.new(1, -10, 0, 40)
_0xL2.Position = UDim2.new(0, 5, 0, 80)
_0xL2.Text = "Trazer Tudo pra Fogueira: OFF"
_0xL2.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
_0xL2.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xL2.Font = Enum.Font.SourceSans
_0xL2.TextSize = 16
_0xL2.MouseButton1Click:Connect(function()
    _0xK1 = not _0xK1
    _0xL2.Text = "Trazer Tudo pra Fogueira: " .. (_0xK1 and "ON" or "OFF")
    _0xL2.BackgroundColor3 = _0xK1 and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
end)

local _0xM3 = Instance.new("UICorner", _0xF6)
_0xM3.CornerRadius = UDim.new(0, 8)
local _0xN4 = Instance.new("UICorner", _0xJ0)
_0xN4.CornerRadius = UDim.new(0, 5)
local _0xO5 = Instance.new("UICorner", _0xL2)
_0xO5.CornerRadius = UDim.new(0, 5)

local function _0xP6()
    return _0xC3:FindFirstChild("Campfire") or _0xC3:FindFirstChildWhichIsA("Model"):FindFirstChild("FirePart") -- Ajuste se nome mudar
end

spawn(function()
    while true do
        wait(0.5)
        if _0xI9 then
            local _0xQ7 = _0xP6()
            if _0xQ7 then
                local _0xR8 = _0xQ7.Position
                local _0xS9 = 10
                local _0xT0 = 12 
                for _0xU1 = 1, _0xT0 do
                    local _0xV2 = _0xR8 + Vector3.new(math.cos(_0xU1 * 2 * math.pi / _0xT0) * _0xS9, 0, math.sin(_0xU1 * 2 * math.pi / _0xT0) * _0xS9)
                    -- Simula plant (use remote se achar, ex: _0xD4.Remotes.PlantSapling:FireServer(_0xV2))
                    -- Pra real: Equipe tool sapling e tp player pra pos, mas isso é básico
                    if _0xH8() then -- Junk
                        _0xB2.Character.HumanoidRootPart.CFrame = CFrame.new(_0xV2) + Vector3.new(0, 5, 0)
                        wait(0.2)
                        -- Fire tool ou remote aqui (ajuste com getgc() pra remotes)
                    end
                end
            end
        end
    end
end)

spawn(function()
    while true do
        wait(0.3)
        if _0xK1 then
            local _0xW3 = _0xP6()
            if _0xW3 then
                local _0xX4 = _0xW3.Position + Vector3.new(0, 3, 0)
                for _, _0xY5 in pairs(_0xC3:GetChildren()) do
                    if _0xY5:IsA("Model") and (_0xY5.Name:match("Tree") or _0xY5.Name:match("Chest") or _0xY5.Name:match("Scrap") or _0xY5.Name:match("Log") or _0xY5.Name:match("Food") or _0xY5.Name:match("Diamond") or _0xY5.Name:match("Item")) then
                        local _0xZ6 = _0xY5:FindFirstChild("Handle") or _0xY5.PrimaryPart or _0xY5
                        if _0xZ6 then
                            _0xZ6.CFrame = CFrame.new(_0xX4)
                        end
                    end
                end
            end
        end
    end
end)
