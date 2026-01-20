local DamageService = require("services.DamageService")
local HealService = require("services.HealService")

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
    self._data.Quests = {}
    self._data.Modifiers = {
        {
            name = "BaseHeal",
            OnHeal = function(mod, event, owner)
                owner = owner._data
                if owner.Health <= 0 then
                    print("Игрок умер! Лечение тут не поможет.")
                    event.isBlocked = true
                elseif owner.Health >= owner.MaxHealth then
                    print("У игрока максимальное здоровье.")
                    event.isBlocked = true
                end
            end
        }
    }

    return self
end

function Character:GetStat(statName)
    return self._data[statName]
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
    for _, mod in ipairs(self._data.Modifiers) do
        if mod[eventName] then
            mod[eventName](mod, eventData or {}, self)
        end
    end
end

function Character:TakeDamage(amount)
    self._data.Health = math.max(self._data.Health - amount, 0)
    if self._data.Health <= 0 then
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

function Character:UseItem(item)
    if type(item) ~= "table" or not item.GetData then
        print("Ошибка при использовании предмета: Укажите экземпляр класса Item.")
        return
    end

    local data = item:GetData()
    local services = {
        Heal = HealService,
        Damage = DamageService
    }

    local service = services[data.Action]
    if service then
        service.apply(self, data.Value, item:GetTags())
    end
end

return Character
