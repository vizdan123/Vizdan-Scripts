local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")

-- Настройки Frame
frame.Size = UDim2.new(0.25, 0, 0.35, 0) -- Размер
frame.Position = UDim2.new(0.375, 0, 0.325, 0) -- Центрирование
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Черный фон
frame.BorderSizePixel = 0
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
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Vizdan Scripts"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = frame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
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
    button.Size = UDim2.new(1, -10, 0.1, 0) -- Уменьшенный размер кнопки
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Цвет кнопки
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text
    button.BorderSizePixel = 0
    button.Parent = frame

    -- Добавление скругления к кнопкам
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10) 
    corner.Parent = button

    -- Добавление круга изменения состояния
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0.05, 0, 0.05, 0) -- Делаем его круглым
    indicator.Position = UDim2.new(0.1, 0, 0.5, 0)
    indicator.AnchorPoint = Vector2.new(0.5, 0.5)
    indicator.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Черный фон для индикатора
    indicator.Parent = button

    -- Добавляем UICorner для круга
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0.5, 0) -- 0.5 делает его круглым
    indicatorCorner.Parent = indicator

    -- Обработчик нажатия кнопки
    button.MouseButton1Click:Connect(function()
        onClick()
        indicator.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный при активации
        wait(1) -- Держим красным 1 секунду

        indicator.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Возвращаем обратно
    end)

    return button
end

-- Создание кнопок
createButton("Скорость 100", UDim2.new(0, 5, 0.1, 0), function()
    print("Скорость 100 активирован")
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.WalkSpeed = 100
    print("Скорость установлена на 100")
end)

createButton("Fly and невидимость", UDim2.new(0, 5, 0.25, 0), function()
    print("Fly and невидимость активирован")
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/lilmond/roblox_fly_script/refs/heads/main/latest.lua'))()
    end)
end)

createButton("ESP", UDim2.new(0, 5, 0.4, 0), function()
    print("ESP активирован")
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/refs/heads/main/Show%20esp.lua"))()
    end)
end)

print("Vizdan Scripts загружен.")
