local Players = game:GetService("Players")

-- Функция для создания полоски HP
local function createHPBar(player)
    -- Ждем, пока персонаж будет доступен
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Создаем BillboardGui
    local billBoardGui = Instance.new("BillboardGui")
    billBoardGui.Adornee = character:FindFirstChild("Head") 
    billBoardGui.Size = UDim2.new(1, 0, 1, 0)
    billBoardGui.StudsOffset = Vector3.new(0, 3, 0)  -- Высота над персонажем
    billBoardGui.Parent = character:FindFirstChild("Head")

    -- Создаем рамку для HP
    local hpFrame = Instance.new("Frame")
    hpFrame.Size = UDim2.new(1, 0, 0.2, 0)  -- Высота 20% относительно родительского объекта
    hpFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный цвет
    hpFrame.Position = UDim2.new(0, 0, 0, 0)
    hpFrame.Parent = billBoardGui

    -- Создаем рамку для обводки
    local outlineFrame = Instance.new("Frame")
    outlineFrame.Size = UDim2.new(1, 0, 1, 0) -- Обводка немного больше
    outlineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- Белый цвет
    outlineFrame.Position = UDim2.new(0, -2, 0, -2) -- Положение обводки
    outlineFrame.Parent = hpFrame

    -- Обновляем здоровье
    humanoid.HealthChanged:Connect(function()
        local healthPercent = humanoid.Health / humanoid.MaxHealth
        hpFrame.Size = UDim2.new(healthPercent, 0, 1, 0) -- Изменяем размер рамки в зависимости от здоровья
    end)

    -- Закругляем углы у рамки
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.2, 0)  -- Закругленные углы
    corner.Parent = hpFrame
end

-- Обработчик для новых игроков
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createHPBar(player) -- Создаем полоску HP для нового персонажа
    end)
    
    -- Создаем полоску HP сразу, если персонаж уже существует
    if player.Character then
        createHPBar(player)
    end
end)

-- Обрабатываем существующих игроков при запуске скрипта
for _, player in ipairs(Players:GetPlayers()) do
    createHPBar(player)
end


-- Пояснения к коду:

--1. **BillboardGui**: Этот элемент отображается над головой персонажа и позволяет рисовать элементы UI.

--2. **Frame для HP**: Этот элемент будет представлять HP персонажа, размер которого будет меняться в зависимости от текущего здоровья.

--3. **Обводка**: Создается дополнительный элемент Frame для выполнения обводки с белым цветом вокруг красной полосы HP.

--4. **Подключение событий**: В скрипте используются событийные обработчики, чтобы отслеживать, когда игроки присоединяются к игре и добавляются к их персонажам.

--5. **Закругленные углы**: Элемент `UICorner` позволяет сделать углы рамки HP закругленными.
