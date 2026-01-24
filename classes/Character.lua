local Inventory = require("classes.Inventory")

local Character = {}
Character.__index = Character

function Character.new(name, class)
    local self = setmetatable({_data = {}}, Character)
    self._data.Name = name
    self._data.Class = class
    self._data.Health = 200
    self._data.MaxHealth = 200
    self._data.Mana = 150
    self._data.MaxMana = 150
    self._data.FistDamage = 8
    self._data.Money = 0
    self._data.Inventory = Inventory.new()
    self._data.Quests = {}
    self._data.Modifiers = {
        {
            name = "BaseHeal",
            OnHeal = function(mod, event, owner)
                data = owner._data
                if data.Health <= 0 then
                    print("Игрок умер! Лечение тут не поможет.")
                    event.isBlocked = true
                elseif data.Health >= data.MaxHealth then
                    print("У игрока максимальное здоровье.")
                    event.isBlocked = true
                end
            end
        }
    }

    return self
end

function Character:GetStat(statName)
    return (type(self._data[statName]) ~= "table") and self._data[statName] or nil
end

function Character:HasModifier(modName)
    local hasMod = false
    for _, mod in ipairs(self._data.Modifiers) do
        if mod.name:lower() == modName:lower() then
            hasMod = true
            break
        end
    end
    return hasMod
end

function Character:ShowStats()
    local name = "Имя: " .. self._data.Name .. ";\n"
    local class = "Класс: " .. self._data.Class .. ";\n"
    local health = "Здоровье: " .. self._data.Health .. ";\n"
    local maxHealth = "Максимальное здоровье: " .. self._data.MaxHealth .. ";"
    print(name .. class .. health .. maxHealth)
end

function Character:TriggerEvent(eventName, eventData)
    eventData = (type(eventData) == "table") and eventData or {}
    local eventLevel = (eventData.tags and eventData.tags.Level) or 1
    for _, mod in ipairs(self._data.Modifiers) do
        local modLevel = (mod.level or mod.lvl) or 1
        if mod[eventName] and eventLevel <= modLevel then
            mod[eventName](mod, eventData, self)
        end
    end
end

function Character:TakeDamage(amount)
    self._data.Health = math.max(self._data.Health - amount, 0)
    if self._data.Health <= 0 and not self:HasModifier("Death") then
        table.insert(self._data.Modifiers, {
            name = "Death",
            OnIncomingDamage = function(mod, event, owner)
                print("Игрок уже умер!")
                event.isBlocked = true
            end
        })
    end
end

function Character:Heal(amount)
    self._data.Health = math.min(self._data.Health + amount, self._data.MaxHealth)
end

function Character:CollectItem(item)
    if type(item) ~= "table" or not item.GetData then
        print("Ошибка при использовании предмета: Укажите экземпляр класса Item.")
        return
    end

    self._data.Inventory:AddItem(item)
end

function Character:DropItem(item)
    if type(item) ~= "table" or not item.GetData then
        print("Ошибка при использовании предмета: Укажите экземпляр класса Item.")
        return
    end

    self._data.Inventory:RemoveItem(item)
end

function Character:UseItem(slot)
    if type(slot) ~= "number" then
        print("Ошибка при использовании предмета: Укажите номер слота.")
        return
    end

    self._data.Inventory:UseItem(slot, self)
end

return Character
