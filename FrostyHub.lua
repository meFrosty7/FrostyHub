-- FrostyHub (Velocidade + Minimizar + Tp Base Personalizado)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- parent seguro
local guiParent
if type(gethui) == "function" then
    local ok, res = pcall(gethui)
    if ok and res then guiParent = res end
end
if not guiParent then guiParent = player:WaitForChild("PlayerGui") end

-- remove GUI antiga se existir
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
Frame.Size = UDim2.new(0, 220, 0, 190)
Frame.Position = UDim2.new(0.1, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
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

-- Botão minimizar
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

-- Botão Velocidade
local btnSpeed = criarBotao("Velocidade", 40)

-- Botão Tp Base personalizado (verde, com texto)
local btnTpBase = Instance.new("TextButton", Frame)
btnTpBase.Size = UDim2.new(0,200,0,50)
btnTpBase.Position = UDim2.new(0,10,0,100)
btnTpBase.Text = "Tp Base"
btnTpBase.BackgroundColor3 = Color3.fromRGB(0,200,0)
btnTpBase.BorderSizePixel = 0
local tpCorner = Instance.new("UICorner", btnTpBase)
tpCorner.CornerRadius = UDim.new(0,12)

-- Logo draggable (ID: 74017393295770)
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
local tpBaseCFrame

-- Funções de Velocidade
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

-- Botão velocidade
btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    updateSpeedVisual()
    aplicarVelocidadeParaChar(player.Character)
end)

-- Aplicar velocidade ao respawn
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid",5)
    task.wait(0.1)
    aplicarVelocidadeParaChar(char)
    if not tpBaseCFrame then
        tpBaseCFrame = char:WaitForChild("HumanoidRootPart").CFrame
    end
end)

-- Função Tp Base
btnTpBase.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and tpBaseCFrame then
        char.HumanoidRootPart.CFrame = tpBaseCFrame
    end
end)

-- Minimizar
btnMin.MouseButton1Click:Connect(function()
    Frame.Visible = false
    logo.Position = Frame.Position
    logo.Visible = true
end)

-- Restaurar ao clicar na logo
logo.MouseButton1Click:Connect(function()
    Frame.Visible = true
    logo.Visible = false
end)

-- Teleporta o player para o Void imediatamente ao iniciar
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart",5)
    task.wait(0.1)
    char.HumanoidRootPart.CFrame = CFrame.new(0, -1000, 0) -- Void
end)

-- Reinicia o personagem para armazenar spawn inicial
player:LoadCharacter()

-- Inicializa
updateSpeedVisual()
-- Title (dentro do frame)
local Title = Instance.new("TextLabel", Frame)
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🧊 | FrostyHub"
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextScaled = true

-- Botão minimizar
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

-- Função criar botão arredondado
local function criarBotao(nome, y)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0,200,0,50)
    btn.Position = UDim2.new(0,10,0,y)
    btn.Text = nome.." OFF"
    btn.BackgroundColor3 = Color3.fromRGB(200,0,0) -- vermelho OFF
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0,12)
    return btn
end

-- Botão Velocidade
local btnSpeed = criarBotao("Velocidade", 40)

-- Botão Tp Base personalizado (verde, sem texto)
local btnTpBase = Instance.new("TextButton", Frame)
btnTpBase.Size = UDim2.new(0,200,0,50)
btnTpBase.Position = UDim2.new(0,10,0,100)
btnTpBase.Text = ""
btnTpBase.BackgroundColor3 = Color3.fromRGB(0,200,0)
btnTpBase.BorderSizePixel = 0
local tpCorner = Instance.new("UICorner", btnTpBase)
tpCorner.CornerRadius = UDim.new(0,12)

-- Logo draggable (ID: 74017393295770)
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
local tpBaseCFrame -- armazenará posição de spawn inicial

-- Funções de Velocidade
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

-- Botão velocidade
btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    updateSpeedVisual()
    aplicarVelocidadeParaChar(player.Character)
end)

-- Aplicar velocidade ao respawn
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid",5)
    task.wait(0.1)
    aplicarVelocidadeParaChar(char)
    -- Se for primeira vez após executar script, armazena posição inicial para Tp Base
    if not tpBaseCFrame then
        tpBaseCFrame = char:WaitForChild("HumanoidRootPart").CFrame
    end
end)

-- Função Tp Base
btnTpBase.MouseButton1Click:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and tpBaseCFrame then
        char.HumanoidRootPart.CFrame = tpBaseCFrame
    end
end)

-- Minimizar
btnMin.MouseButton1Click:Connect(function()
    Frame.Visible = false
    logo.Position = Frame.Position
    logo.Visible = true
end)

-- Restaurar ao clicar na logo
logo.MouseButton1Click:Connect(function()
    Frame.Visible = true
    logo.Visible = false
end)

-- Reinicia o personagem para armazenar posição de spawn inicial
player:LoadCharacter()

-- Inicializa
updateSpeedVisual()
