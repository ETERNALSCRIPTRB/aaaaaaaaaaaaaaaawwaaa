local pl = game:GetService("Players").LocalPlayer
local pg = pl:WaitForChild("PlayerGui")
local sg = Instance.new("ScreenGui")
sg.Name = "MagicGUI"
sg.Parent = pg
sg.ResetOnSpawn = false

local openBtn = Instance.new("TextButton")
openBtn.Parent = sg
openBtn.Size = UDim2.fromOffset(180,70)
openBtn.Position = UDim2.new(0.5,-90,0,10)
openBtn.BackgroundColor3 = Color3.fromRGB(10,10,10)
openBtn.Text = ""
openBtn.BorderSizePixel = 0

local corner1 = Instance.new("UICorner")
corner1.CornerRadius = UDim.new(0,8)
corner1.Parent = openBtn

local label = Instance.new("TextLabel")
label.Parent = openBtn
label.Text = "Magic Client"
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(128,0,128)
label.TextSize = 18
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.TextXAlignment = Enum.TextXAlignment.Center
label.TextYAlignment = Enum.TextYAlignment.Center

local panel = Instance.new("Frame")
panel.Parent = sg
panel.BackgroundColor3 = Color3.fromRGB(15,15,15)
panel.BackgroundTransparency = 0.4
panel.Size = UDim2.fromOffset(450,500)
panel.Position = UDim2.new(0.5,-225,0.5,-250)
panel.Visible = false
panel.BorderSizePixel = 0

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0,16)
corner2.Parent = panel

local title = Instance.new("TextLabel")
title.Parent = panel
title.Text = "credits-ETERNALSCRIPTRB"
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(255,0,255)
title.TextSize = 24
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Center

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = panel
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Size = UDim2.fromOffset(40,40)
closeBtn.Position = UDim2.new(1,-50,0,5)
closeBtn.BorderSizePixel = 0

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0,8)
corner3.Parent = closeBtn

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = panel
scroll.BackgroundTransparency = 1
scroll.Size = UDim2.new(1,-20,1,-70)
scroll.Position = UDim2.new(0,10,0,60)
scroll.CanvasSize = UDim2.new(0,0,0,1200)
scroll.ScrollBarThickness = 10

local grid = Instance.new("UIGridLayout")
grid.Parent = scroll
grid.CellSize = UDim2.new(0.48,0,0,55)
grid.CellPadding = UDim2.new(0,10,0,10)

local t = {a=false,k=false,s=false,f=false,j=false,n=false,c=false,e=false,fb=false,g=false,afk=false} -- toggles novos
local conn = {}
local bvFly = nil
local espBoxes = {}

local function getCh()
    if pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") and pl.Character:FindFirstChild("Humanoid") then
        return pl.Character
    end
    pl.CharacterAdded:Wait()
    task.wait(1)
    return getCh()
end

local function makeBtn(name, order)
    local b = Instance.new("TextButton")
    b.Parent = scroll
    b.Text = name:upper().." OFF"
    b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 16
    b.LayoutOrder = order
    b.BorderSizePixel = 0
    local cr = Instance.new("UICorner")
    cr.CornerRadius = UDim.new(0,10)
    cr.Parent = b
    return b
end

-- Botões originais
local b1 = makeBtn("Aimbot",1)
local b2 = makeBtn("Kill Aura",2)
local b3 = makeBtn("Speed",3)
local b4 = makeBtn("Fly",4)
local b5 = makeBtn("Inf Jump",5)
local b6 = makeBtn("Noclip",6)
local b7 = makeBtn("Click TP",7)

-- Novos botões (sequenciais)
local b8 = makeBtn("ESP",8)
local b9 = makeBtn("Fullbright",9)
local b10 = makeBtn("Godmode",10)
local b11 = makeBtn("Anti-AFK",11)
local b12 = makeBtn("Infinite Yield",12)
local b13 = makeBtn("Owl Hub",13)
local b14 = makeBtn("Speed Hub X",14)

-- Executor Custom (textbox + execute button)
local execFrame = Instance.new("Frame")
execFrame.Parent = scroll
execFrame.Size = UDim2.new(0.96,0,0,120)
execFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
execFrame.LayoutOrder = 15
local execCorner = Instance.new("UICorner")
execCorner.Parent = execFrame
execCorner.CornerRadius = UDim.new(0,10)

local execBox = Instance.new("TextBox")
execBox.Parent = execFrame
execBox.Size = UDim2.new(1,-20,0.6,0)
execBox.Position = UDim2.new(0,10,0,10)
execBox.PlaceholderText = "Cole loadstring aqui..."
execBox.Text = ""
execBox.MultiLine = true
execBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
local execBoxCorner = Instance.new("UICorner")
execBoxCorner.Parent = execBox

local execBtn = Instance.new("TextButton")
execBtn.Parent = execFrame
execBtn.Size = UDim2.new(1,-20,0.3,0)
execBtn.Position = UDim2.new(0,10,0.7,0)
execBtn.Text = "EXECUTE"
execBtn.BackgroundColor3 = Color3.fromRGB(0,170,255)
execBtn.TextColor3 = Color3.new(1,1,1)
local execBtnCorner = Instance.new("UICorner")
execBtnCorner.Parent = execBtn

-- Funções originais (mantidas iguais)
-- AIMBOT (igual)
b1.MouseButton1Click:Connect(function()
    t.a = not t.a
    b1.Text = "AIMBOT "..(t.a and "ON" or "OFF")
    b1.BackgroundColor3 = t.a and Color3.fromRGB(0,255,0) or Color3.fromRGB(40,40,40)
    if conn.a then conn.a:Disconnect() end
    if t.a then
        conn.a = game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                local closest = nil
                local dist = math.huge
                for _,p in game.Players:GetPlayers() do
                    if p ~= pl and p.Character and p.Character:FindFirstChild("Head") then
                        local d = (p.Character.Head.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
                        if d < dist then closest = p dist = d end
                    end
                end
                if closest and dist < 300 then
                    workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position)
                end
            end)
        end)
    end
end)

-- KILL AURA (igual)
b2.MouseButton1Click:Connect(function()
    t.k = not t.k
    b2.Text = "KILL AURA "..(t.k and "ON" or "OFF")
    b2.BackgroundColor3 = t.k and Color3.fromRGB(255,0,0) or Color3.fromRGB(40,40,40)
    if conn.k then conn.k:Disconnect() end
    if t.k then
        conn.k = game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                local char = getCh()
                local hrp = char.HumanoidRootPart
                for _,p in game.Players:GetPlayers() do
                    if p ~= pl and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                        local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if dist < 30 then
                            p.Character.Humanoid.Health = 0
                            p.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0,-200,0)
                        end
                    end
                end
            end)
        end)
    end
end)

-- SPEED (igual)
b3.MouseButton1Click:Connect(function()
    t.s = not t.s
    b3.Text = "SPEED "..(t.s and "ON" or "OFF")
    b3.BackgroundColor3 = t.s and Color3.fromRGB(0,200,255) or Color3.fromRGB(40,40,40)
    pcall(function()
        getCh().Humanoid.WalkSpeed = t.s and 100 or 16
    end)
end)

-- FLY (igual)
b4.MouseButton1Click:Connect(function()
    t.f = not t.f
    b4.Text = "FLY "..(t.f and "ON" or "OFF")
    b4.BackgroundColor3 = t.f and Color3.fromRGB(0,255,255) or Color3.fromRGB(40,40,40)
    if conn.f then conn.f:Disconnect() end
    pcall(function()
        local char = getCh()
        local hrp = char.HumanoidRootPart
        local hum = char.Humanoid
        if t.f then
            hum.PlatformStand = true
            bvFly = Instance.new("BodyVelocity")
            bvFly.MaxForce = Vector3.new(4000,4000,4000)
            bvFly.Velocity = Vector3.new(0,0,0)
            bvFly.Parent = hrp
            conn.f = game:GetService("RunService").Heartbeat:Connect(function()
                bvFly.Velocity = workspace.CurrentCamera.CFrame.LookVector * 60 + Vector3.new(0,20,0)
            end)
        else
            hum.PlatformStand = false
            if bvFly then bvFly:Destroy() bvFly = nil end
        end
    end)
end)

-- INF JUMP (igual)
b5.MouseButton1Click:Connect(function()
    t.j = not t.j
    b5.Text = "INF JUMP "..(t.j and "ON" or "OFF")
    b5.BackgroundColor3 = t.j and Color3.fromRGB(255,255,0) or Color3.fromRGB(40,40,40)
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if t.j then
        pcall(function()
            pl.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end)
    end
end)

-- NOCLIP (igual)
b6.MouseButton1Click:Connect(function()
    t.n = not t.n
    b6.Text = "NOCLIP "..(t.n and "ON" or "OFF")
    b6.BackgroundColor3 = t.n and Color3.fromRGB(255,128,0) or Color3.fromRGB(40,40,40)
    if conn.n then conn.n:Disconnect() end
    if t.n then
        conn.n = game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                for _,part in pairs(getCh():GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end)
    else
        pcall(function()
            for _,part in pairs(getCh():GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end)
    end
end)

-- CLICK TP (igual, mobile touch)
b7.MouseButton1Click:Connect(function()
    t.c = not t.c
    b7.Text = "CLICK TP "..(t.c and "ON" or "OFF")
    b7.BackgroundColor3 = t.c and Color3.fromRGB(128,0,255) or Color3.fromRGB(40,40,40)
end)

game:GetService("UserInputService").TouchTap:Connect(function(touches, processed)
    if t.c and not processed then
        pcall(function()
            local pos = touches[1]
            local ray = workspace.CurrentCamera:ScreenPointToRay(pos.X, pos.Y)
            local result = workspace:Raycast(ray.Origin, ray.Direction * 500)
            if result then
                getCh().HumanoidRootPart.CFrame = CFrame.new(result.Position + Vector3.new(0,5,0))
            end
        end)
    end
end)

-- ESP (novo - caixas + nome + health)
b8.MouseButton1Click:Connect(function()
    t.e = not t.e
    b8.Text = "ESP "..(t.e and "ON" or "OFF")
    b8.BackgroundColor3 = t.e and Color3.fromRGB(255,0,0) or Color3.fromRGB(40,40,40)
    if conn.e then conn.e:Disconnect() end
    for _,box in pairs(espBoxes) do if box then box:Destroy() end end
    espBoxes = {}
    if t.e then
        conn.e = game:GetService("RunService").Heartbeat:Connect(function()
            pcall(function()
                for _,p in game.Players:GetPlayers() do
                    if p ~= pl and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") then
                        if not espBoxes[p] then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Adornee = p.Character
                            box.AlwaysOnTop = true
                            box.ZIndex = 10
                            box.Transparency = 0.6
                            box.Color3 = Color3.fromRGB(255,0,0)
                            box.Size = Vector3.new(4,6,4)
                            box.Parent = p.Character

                            local name = Instance.new("BillboardGui")
                            name.Adornee = p.Character.Head
                            name.AlwaysOnTop = true
                            name.Size = UDim2.new(0,100,0,50)
                            name.StudsOffset = Vector3.new(0,3,0)
                            local nameLabel = Instance.new("TextLabel")
                            nameLabel.Text = p.Name.." ["..math.floor(p.Character.Humanoid.Health).."]"
                            nameLabel.BackgroundTransparency = 1
                            nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
                            nameLabel.Size = UDim2.new(1,0,1,0)
                            nameLabel.Parent = name
                            name.Parent = p.Character

                            espBoxes[p] = {box, name}
                        end
                    end
                end
            end)
        end)
    end
end)

b9.MouseButton1Click:Connect(function()
    t.fb = not t.fb
    b9.Text = "FULLBRIGHT "..(t.fb and "ON" or "OFF")
    b9.BackgroundColor3 = t.fb and Color3.fromRGB(255,255,255) or Color3.fromRGB(40,40,40)
    game:GetService("Lighting").Brightness = t.fb and 5 or 1
    game:GetService("Lighting").GlobalShadows = not t.fb
    game:GetService("Lighting").FogEnd = t.fb and 100000 or 100000
end)

b10.MouseButton1Click:Connect(function()
    t.g = not t.g
    b10.Text = "GODMODE "..(t.g and "ON" or "OFF")
    b10.BackgroundColor3 = t.g and Color3.fromRGB(0,255,0) or Color3.fromRGB(40,40,40)
    pcall(function()
        local hum = getCh().Humanoid
        hum.MaxHealth = t.g and math.huge or 100
        hum.Health = t.g and math.huge or 100
    end)
end)

b11.MouseButton1Click:Connect(function()
    t.afk = not t.afk
    b11.Text = "ANTI-AFK "..(t.afk and "ON" or "OFF")
    b11.BackgroundColor3 = t.afk and Color3.fromRGB(0,255,255) or Color3.fromRGB(40,40,40)
    if conn.afk then conn.afk:Disconnect() end
    if t.afk then
        conn.afk = pl.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
    end
end)

b12.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

b13.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
end)

b14.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
end)

execBtn.MouseButton1Click:Connect(function()
    if execBox.Text ~= "" then
        loadstring(execBox.Text)()
        execBox.Text = "Executado!"
        task.wait(1)
        execBox.Text = ""
    end
end)

pl.CharacterAdded:Connect(function()
    task.wait(1)
    if t.s then pcall(function() pl.Character.Humanoid.WalkSpeed = 100 end) end
    if t.g then pcall(function() pl.Character.Humanoid.MaxHealth = math.huge; pl.Character.Humanoid.Health = math.huge end) end
end)

openBtn.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    panel.Visible = false
end)
