print("START!")

function love.draw()
    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()
    
    -- Размер кнопок (пусть будет 10% от ширины экрана для адаптивности)
    local radius = sw * 0.05 

    -- КНОПКА №1 (Справа внизу)
    -- Правый отступ 25%: sw * 0.75
    -- Нижний отступ 5%: sh * 0.95 (отнимаем от низа 5%)
    local b1x = sw * 0.75
    local b1y = sh * 0.95 - radius -- Вычитаем радиус, чтобы центр был выше края
    
    love.graphics.setColor(1, 0, 0) -- Красная
    love.graphics.circle("fill", b1x, b1y, radius)

    -- КНОПКА №2 (Выше и правее)
    -- Правый отступ 15%: sw * 0.85
    -- Нижний отступ 15%: sh * 0.85
    local b2x = sw * 0.85
    local b2y = sh * 0.85 - radius
    
    love.graphics.setColor(0, 1, 0) -- Зеленая
    love.graphics.circle("fill", b2x, b2y, radius)
    
    love.graphics.setColor(1, 1, 1) -- Сброс цвета в белый
end
