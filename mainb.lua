local CharacterFactory = require("factories.CharacterFactory")
local DamageService = require("services.DamageService")

local Player = CharacterFactory.apply("Void", "Alchemist")
local visualHp = 0

function love.load()
    -- Инициализируем визуальное ХП
    visualHp = Player:GetStat("Health")
end

function love.update(dt)
    -- Получаем АКТУАЛЬНОЕ значение из твоего объекта
    local currentHp = Player:GetStat("Health")
    
    -- Интерполяция (плавное движение visual к current)
    if math.abs(visualHp - currentHp) > 0.1 then
        visualHp = visualHp + (currentHp - visualHp) * 8 * dt
    else
        visualHp = currentHp
    end
end

function love.draw()
    local hp = Player:GetStat("Health")
    local maxHp = Player:GetStat("MaxHealth")
    
    -- Рисуем полоску
    love.graphics.setColor(0.1, 0.1, 0.1)
    love.graphics.rectangle("fill", 50, 100, 300, 30) -- Фон
    
    love.graphics.setColor(1, 0.2, 0.2)
    love.graphics.rectangle("fill", 50, 100, 300 * (visualHp / maxHp), 30) -- Плавная полоска
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", 50, 100, 300, 30) -- Рамка
    
    -- Текст для проверки
    love.graphics.print("Real HP: " .. hp, 50, 80)
    love.graphics.print("Visual HP: " .. math.floor(visualHp), 50, 140)
    love.graphics.print("Tap anywhere to HIT", 50, 180)
end

-- На телефонах иногда лучше работает touchpressed, 
-- но LÖVE обычно транслирует тапы в mousepressed. 
-- Давай пропишем оба для надежности.

function love.mousepressed(x, y, button)
    -- Прямое воздействие через твой сервис
    DamageService.apply(Player, 20, { SourceType = "Test" })
end
