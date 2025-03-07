-- LocalScript, который вы можете разместить в StarterPlayerScripts или StarterGui

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")

-- Настройки Frame
frame.Size = UDim2.new(0.1, 0, 0.2, 0) -- Увеличен размер фрейма
frame.Position = UDim2.new(0.45, 0, 0.4, 0) -- Центрирование
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Цвет фона (темно-серый)
frame.BorderSizePixel = 0 -- Убираем рамку
frame.Parent = screenGui

screenGui.Parent = player:WaitForChild("PlayerGui")

-- Перемещение фрейма мышью
local dragging = false
local dragInput, mousePos, framePos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragInput = input
        mousePos = input.Position
        framePos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - mousePos
        frame.Position = framePos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Заголовок
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.1, 0) -- Размер заголовка
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Vizdan Scripts"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true -- Подгоняет текст под размер
titleLabel.Parent = frame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0) -- Размер кнопки закрытия
closeButton.Position = UDim2.new(0.9, 0, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный цвет
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Text = "X"
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy() -- Закрытие меню
end)

-- Функция для создания кнопки
local function createButton(text, position, onClick)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0.06, 0) -- Увеличенный размер кнопки
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Цвет кнопки
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.BorderSizePixel = 0
    button.TextScaled = true -- Подгоняет текст под размер
    button.Parent = frame

    -- Добавление скругления к кнопкам
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 5) -- Скругление углов
    corner.Parent = button

    -- Обработчик нажатия кнопки
    button.MouseButton1Click:Connect(onClick)

    return button
end

-- Создание кнопок
createButton("Скорость 100", UDim2.new(0, 5, 0.1, 0), function()
    print("Скорость 100 активирован")
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local targetSpeed = 100

    local function setSpeed()
        humanoid.WalkSpeed = targetSpeed
    end

    while true do
        if humanoid.WalkSpeed ~= targetSpeed then
            setSpeed()
            print("Скорость восстановлена до " .. targetSpeed)
        end

        wait(0.1)
    end
end)

createButton("Fly and невидимость", UDim2.new(0, 5, 0.17, 0), function()
    print("Fly and невидимость активирован")
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/lilmond/roblox_fly_script/refs/heads/main/latest.lua'))()
    end)
end)

createButton("ESP", UDim2.new(0, 5, 0.24, 0), function()
    print("ESP активирован")
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/Show%20esp.lua"))()
    end)
end)

createButton("ctrl+click tp", UDim2.new(0, 5, 0.31, 0), function()
    print("ctrl+click tp  активирован")
    -- --[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local UIS = game:GetService("UserInputService")

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()


function GetCharacter()
   return game.Players.LocalPlayer.Character
end

function Teleport(pos)
   local Char = GetCharacter()
   if Char then
       Char:MoveTo(pos)
   end
end


UIS.InputBegan:Connect(function(input)
   if input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
       Teleport(Mouse.Hit.p)
   end
end)
end)
