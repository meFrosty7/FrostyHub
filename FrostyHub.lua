-- FrostyHub (Speed + Tp Base + Auto Steal + Auto Secret Pet + Reset Único + Key Diário + Reset Automático)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Parent seguro
local guiParent
if type(gethui) == "function" then
    local ok, res = pcall(gethui)
    if ok and res then guiParent = res end
end
if not guiParent then guiParent = player:WaitForChild("PlayerGui") end

-- Remove GUI antiga
local old = guiParent:FindFirstChild("FrostyHub")
if old then old:Destroy() end

-- =====================
-- RESET AUTOMÁTICO 3s APÓS INICIAR
-- =====================
if not getgenv().FrostyHub_ResetDone then
    getgenv().FrostyHub_ResetDone = true
    spawn(function()
        task.wait(3)
        if player.Character then
            player:LoadCharacter()
        end
    end)
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FrostyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = guiParent

-- =====================
-- FRAME PRINCIPAL
-- =====================
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 360, 0, 220)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 15)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Name = "Title"
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🧊 | FrostyHub"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Title.TextStrokeTransparency = 0.7
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Botão Minimizar
local MinBtn = Instance.new("TextButton", Frame)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 0)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextScaled = true
local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, 8)

-- =====================
-- KEY SYSTEM
-- =====================
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 250, 0, 120)
KeyFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = ScreenGui

local KeyCorner = Instance.new("UICorner", KeyFrame)
KeyCorner.CornerRadius = UDim.new(0, 12)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(0, 200, 0, 35)
KeyBox.Position = UDim2.new(0.5, -100, 0.2, 0)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Text = ""
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.Font = Enum.Font.SourceSansBold
KeyBox.TextScaled = true
local KeyCorner2 = Instance.new("UICorner", KeyBox)
KeyCorner2.CornerRadius = UDim.new(0, 8)

local Submit = Instance.new("TextButton", KeyFrame)
Submit.Size = UDim2.new(0, 120, 0, 30)
Submit.Position = UDim2.new(0.5, -60, 0.55, 0)
Submit.Text = "Confirm"
Submit.BackgroundColor3 = Color3.fromRGB(0,170,255)
Submit.TextColor3 = Color3.fromRGB(255,255,255)
Submit.Font = Enum.Font.SourceSansBold
Submit.TextScaled = true
local SubmitCorner = Instance.new("UICorner", Submit)
SubmitCorner.CornerRadius = UDim.new(0, 8)

local InvalidMsg = Instance.new("TextLabel", KeyFrame)
InvalidMsg.Size = UDim2.new(1, 0, 0, 25)
InvalidMsg.Position = UDim2.new(0, 0, 0.85, 0)
InvalidMsg.BackgroundTransparency = 1
InvalidMsg.Text = ""
InvalidMsg.TextColor3 = Color3.fromRGB(255,0,0)
InvalidMsg.Font = Enum.Font.SourceSansBold
InvalidMsg.TextScaled = true

-- Key Config
local currentKey = "frostyhub"
local date = os.date("!*t").yday

if not getgenv().FrostyHub_KeyDate or getgenv().FrostyHub_KeyDate ~= date then
    getgenv().FrostyHub_HasKey = false
end

if getgenv().FrostyHub_HasKey then
    KeyFrame.Visible = false
    Frame.Visible = true
end

Submit.MouseButton1Click:Connect(function()
    if string.lower(KeyBox.Text) == currentKey then
        getgenv().FrostyHub_HasKey = true
        getgenv().FrostyHub_KeyDate = date
        KeyFrame.Visible = false
        Frame.Visible = true
    else
        InvalidMsg.Text = "Key Invalid"
        task.delay(5, function()
            if InvalidMsg then
                InvalidMsg.Text = ""
            end
        end)
    end
end)

-- =====================
-- BOTÕES
-- =====================
local function criarBotao(nome, x, y)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 120, 0, 40)
    btn.Position = UDim2.new(0, x, 0, y)
    btn.Text = nome
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0,12)
    return btn
end

local btnSpeed = criarBotao("Speed", 10, 40)
local btnTpBase = Instance.new("TextButton", Frame)
btnTpBase.Size = UDim2.new(0,120,0,40)
btnTpBase.Position = UDim2.new(0, 170, 0, 40)
btnTpBase.Text = "Tp Base"
btnTpBase.BackgroundColor3 = Color3.fromRGB(50,50,50)
btnTpBase.BorderSizePixel = 0
btnTpBase.TextColor3 = Color3.fromRGB(255,255,255)
btnTpBase.Font = Enum.Font.SourceSansBold
btnTpBase.TextScaled = true
local tpCorner = Instance.new("UICorner", btnTpBase)
tpCorner.CornerRadius = UDim.new(0,12)

local btnAutoSteal = criarBotao("Auto Steal", 10, 100)
local btnAutoSecretPet = criarBotao("Auto Secret Pet", 170, 100)

-- =====================
-- SPEED SYSTEM
-- =====================
local speedOn = false
local speedValue = 120
local normalSpeed = 16

local function updateSpeedVisual()
    if speedOn then
        btnSpeed.Text = "Speed ON"
        btnSpeed.BackgroundColor3 = Color3.fromRGB(0,200,0)
    else
        btnSpeed.Text = "Speed OFF"
        btnSpeed.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end

btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    updateSpeedVisual()
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedOn and speedValue or normalSpeed
    end
end)

spawn(function()
    while true do
        task.wait(1)
        if speedOn then
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.WalkSpeed < speedValue then
                humanoid.WalkSpeed = speedValue
            end
        end
    end
end)

player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid",5)
    task.wait(0.5)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and speedOn then
        humanoid.WalkSpeed = speedValue
    end
end)

-- =====================
-- TP BASE SYSTEM
-- =====================
local tpBaseCFrame = nil
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp and not tpBaseCFrame then
        tpBaseCFrame = hrp.CFrame
    end
end)

btnTpBase.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and tpBaseCFrame then
        char.HumanoidRootPart.CFrame = tpBaseCFrame
    end
end)

-- =====================
-- AUTO STEAL
-- =====================
local autoStealOn = false
btnAutoSteal.MouseButton1Click:Connect(function()
    autoStealOn = not autoStealOn
    if autoStealOn then
        btnAutoSteal.Text = "Auto Steal ON"
        btnAutoSteal.BackgroundColor3 = Color3.fromRGB(0,200,0)
    else
        btnAutoSteal.Text = "Auto Steal"
        btnAutoSteal.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end)

-- Conectar a um evento global quando o player usa um ProximityPrompt com ActionText "Steal"
game:GetService("ProximityPromptService").PromptTriggered:Connect(function(prompt, plr)
    if autoStealOn and plr == player and prompt.ActionText == "Steal" then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") and tpBaseCFrame then
            char.HumanoidRootPart.CFrame = tpBaseCFrame
        end
    end
end)

-- =====================
-- AUTO SECRET PET (exemplo placeholder)
-- =====================
local autoPetOn = false
btnAutoSecretPet.MouseButton1Click:Connect(function()
    autoPetOn = not autoPetOn
    if autoPetOn then
        btnAutoSecretPet.Text = "Auto Secret Pet ON"
        btnAutoSecretPet.BackgroundColor3 = Color3.fromRGB(0,200,0)
    else
        btnAutoSecretPet.Text = "Auto Secret Pet"
        btnAutoSecretPet.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end)

-- =====================
-- MINIMIZE / RESTORE
-- =====================
MinBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    local MiniBtn = Instance.new("ImageButton", ScreenGui)
    MiniBtn.Name = "MiniBtn"
    MiniBtn.Size = UDim2.new(0,50,0,50)
    MiniBtn.Position = Frame.Position
    MiniBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    MiniBtn.Image = "rbxassetid://74017393295770"
    MiniBtn.AutoButtonColor = true
    MiniBtn.Active = true
    MiniBtn.Draggable = true
    local mc = Instance.new("UICorner", MiniBtn)
    mc.CornerRadius = UDim.new(0,12)

    MiniBtn.MouseButton1Click:Connect(function()
        Frame.Visible = true
        MiniBtn:Destroy()
    end)
end)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 15)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🧊 | FrostyHub"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true
Title.TextStrokeTransparency = 0.7

-- Função criar botão arredondado (vermelho ON/OFF)
local function criarBotao(nome, y)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0,200,0,50)
    btn.Position = UDim2.new(0,10,0,y)
    btn.Text = nome.." OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0,12)
    return btn
end

-- Botões
local btnSpeed = criarBotao("Velocidade", 40)

-- Botão Tp Base (cinza escuro)
local btnTpBase = Instance.new("TextButton", Frame)
btnTpBase.Size = UDim2.new(0,200,0,50)
btnTpBase.Position = UDim2.new(0,10,0,100)
btnTpBase.Text = "Tp Base"
btnTpBase.BackgroundColor3 = Color3.fromRGB(50,50,50) -- cinza escuro
btnTpBase.BorderSizePixel = 0
btnTpBase.TextColor3 = Color3.fromRGB(255,255,255) -- texto branco
btnTpBase.Font = Enum.Font.SourceSansBold
btnTpBase.TextScaled = true
local tpCorner = Instance.new("UICorner", btnTpBase)
tpCorner.CornerRadius = UDim.new(0,12)

local btnAutoSteal = criarBotao("Auto Steal", 160)
local autoStealOn = false

local btnAutoSecretPet = criarBotao("Auto Secret Pet", 220)
local autoSecretPetOn = false
local secretPetNames = {
    ["Garama and Madundung"]=true,
    ["Amalgamation"]=true,
    ["Los Tralalelitos"]=true,
    ["Burbaloni Lulioli"]=true,
    ["Job Job Job Sahur"]=true,
    ["Pot Hotspot"]=true
}

-- Logo draggable
local logo = Instance.new("ImageButton", ScreenGui)
logo.Name = "FrostyLogo"
logo.Size = UDim2.new(0, 50, 0, 50)
logo.Position = Frame.Position
logo.BackgroundColor3 = Color3.fromRGB(30,30,30)
logo.BorderSizePixel = 0
logo.AutoButtonColor = true
logo.Image = "rbxassetid://74017393295770"
logo.Visible = false
logo.Active = true
logo.Draggable = true
local logoCorner = Instance.new("UICorner", logo)
logoCorner.CornerRadius = UDim.new(0,12)

-- Variáveis
local speedOn = false
local tpBaseCFrame = nil

-- Funções
local function updateSpeedVisual()
    if speedOn then
        btnSpeed.Text = "Velocidade ON"
        btnSpeed.BackgroundColor3 = Color3.fromRGB(0,200,0)
    else
        btnSpeed.Text = "Velocidade OFF"
        btnSpeed.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end

local function aplicarVelocidadeParaChar(character)
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedOn and 120 or 16
    end
end

-- Botão Velocidade
btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    updateSpeedVisual()
    aplicarVelocidadeParaChar(player.Character)
end)

-- Botão Tp Base
btnTpBase.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and tpBaseCFrame then
        char.HumanoidRootPart.CFrame = tpBaseCFrame
    end
end)

-- Botão Auto Steal
local function monitorProximitySteal()
    for _, prompt in ipairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.ActionText == "Steal" then
            prompt.Triggered:Connect(function(plr)
                if plr == player and autoStealOn and tpBaseCFrame then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = tpBaseCFrame
                    end
                end
            end)
        end
    end
end

btnAutoSteal.MouseButton1Click:Connect(function()
    autoStealOn = not autoStealOn
    if autoStealOn then
        btnAutoSteal.Text = "Auto Steal ON"
        btnAutoSteal.BackgroundColor3 = Color3.fromRGB(0,200,0)
        monitorProximitySteal()
    else
        btnAutoSteal.Text = "Auto Steal OFF"
        btnAutoSteal.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end)

-- Auto Secret Pet loop usando ObjectText
spawn(function()
    while true do
        task.wait(1)
        if autoSecretPetOn and tpBaseCFrame then
            for _, prompt in ipairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and secretPetNames[prompt.ObjectText] then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = prompt.Parent.CFrame
                        task.wait(0.2)
                        fireproximityprompt(prompt)
                        task.wait(0.2)
                        char.HumanoidRootPart.CFrame = tpBaseCFrame
                    end
                end
            end
        end
    end
end)

btnAutoSecretPet.MouseButton1Click:Connect(function()
    autoSecretPetOn = not autoSecretPetOn
    if autoSecretPetOn then
        btnAutoSecretPet.Text = "Auto Secret Pet ON"
        btnAutoSecretPet.BackgroundColor3 = Color3.fromRGB(0,200,0)
    else
        btnAutoSecretPet.Text = "Auto Secret Pet OFF"
        btnAutoSecretPet.BackgroundColor3 = Color3.fromRGB(200,0,0)
    end
end)

-- Aplicar velocidade e definir Tp Base ao respawn
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid",5)
    task.wait(0.1)
    aplicarVelocidadeParaChar(char)
    if not tpBaseCFrame then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            tpBaseCFrame = hrp.CFrame
        end
    end
end)

-- Minimizar/Restaurar
local btnMin = Instance.new("TextButton", Frame)
btnMin.Name = "Minimize"
btnMin.Size = UDim2.new(0, 28, 0, 22)
btnMin.Position = UDim2.new(1, -32, 0, 4)
btnMin.BackgroundColor3 = Color3.fromRGB(60,60,60)
btnMin.BorderSizePixel = 0
btnMin.Text = "—"
btnMin.Font = Enum.Font.SourceSansBold
btnMin.TextScaled = true
btnMin.TextColor3 = Color3.fromRGB(255,255,255)
local minCorner = Instance.new("UICorner", btnMin)
minCorner.CornerRadius = UDim.new(0,6)

btnMin.MouseButton1Click:Connect(function()
    Frame.Visible = false
    logo.Visible = true
end)

logo.MouseButton1Click:Connect(function()
    Frame.Visible = true
    logo.Visible = false
end)

-- Inicializa
updateSpeedVisual()
