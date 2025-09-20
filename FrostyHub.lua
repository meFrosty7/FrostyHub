-- FrostyHub (Velocidade + Tp Base + Auto Steal + Auto Secret Pet)
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

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FrostyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = guiParent

-- Frame principal
local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 220, 0, 260)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 15)

-- Função criar botão arredondado
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

-- Botão Tp Base (igual visualmente aos outros)
local btnTpBase = Instance.new("TextButton", Frame)
btnTpBase.Size = UDim2.new(0,200,0,50)
btnTpBase.Position = UDim2.new(0,10,0,100)
btnTpBase.Text = "Tp Base OFF"
btnTpBase.BackgroundColor3 = Color3.fromRGB(0,200,0)
btnTpBase.BorderSizePixel = 0
btnTpBase.TextColor3 = Color3.fromRGB(255,255,255)
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
                        -- Teleporta para o objeto/part que contém o ProximityPrompt
                        char.HumanoidRootPart.CFrame = prompt.Parent.CFrame
                        task.wait(0.2)
                        -- Usa o ProximityPrompt sozinho
                        fireproximityprompt(prompt)
                        task.wait(0.2)
                        -- Volta para Tp Base
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

-- Minimizar/Restaurar sem ativar ao arrastar
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
