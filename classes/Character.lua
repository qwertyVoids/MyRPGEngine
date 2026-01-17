local Character = {}
Character.__index = Character

function Character.new(name, class)
    local self = setmetatable({
        Name = name,
        Class = class,
        Health = 200,
        MaxHealth = 200,
        Mana = 150,
        MaxMana = 150,
        Modifiers = {}
    }, Character)

    return self
end

function Character:TriggerEvent(eventName, eventData)
    for _, mod in ipairs(self.Modifiers) do
        if mod[eventName] then
            mod[eventName](mod, eventData, self)
        end
    end
end

function Character:TakeDamage(amount)
    if self.Health > 0 then
        self.Health = math.max(self.Health - amount, 0)
    else
        print("Игрок " .. self.Name .. " уже умер!")
    end
end

function Character:Heal(amount)
    if self.Health > 0 and self.Health < self.MaxHealth then
        self.Health = math.min(self.Health + amount, self.MaxHealth)
    else
        print("Не удалось восстановить здоровье! Игрок либо уже умер, либо у него уже максимальное здоровье.")
    end
end

function Character:showStats()
    local name = "Имя: " .. self.Name .. ";\n"
    local class = "Класс: " .. self.Class .. ";\n"
    local health = "Здоровье: " .. self.Health .. ";\n"
    local maxHealth = "Максимальное здоровье: " .. self.MaxHealth .. ";"
    print(name .. class .. health .. maxHealth)
end

return Character
