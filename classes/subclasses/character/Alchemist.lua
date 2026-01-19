local Character = require("classes.Character")
local Alchemist = setmetatable({}, {__index = Character})
Alchemist.__index = Alchemist

function Alchemist.new(name)
    local self = Character.new(name, "Alchemist")
    setmetatable(self, Alchemist)

    table.insert(self._data.Modifiers, {
        name = "AlchemistMastery",
        mult = 2,
        OnHeal = function(mod, event, owner)
            owner = owner._data
            if next(event.tags) ~= nil then
                if event.tags.SourceType == "Potion" and event.tags.IsPositive then
                    event.amount = event.amount * mod.mult
                    print("Алхимик " .. owner.Name .. " выпил зелье и сработало его мастерство!")
                end
            end
        end
    })
    table.insert(self._data.Modifiers, {
        name = "AlchemistMastery",
        mult = 2,
        OnStatCalculate = function(mod, event, owner)
            owner = owner._data
            if next(event.tags) ~= nil then
                if event.tags.SourceType == "Potion" and event.tags.IsPositive then
                    event.amount = event.amount * mod.mult
                    print("Алхимик " .. owner.Name .. " выпил зелье и сработало его мастерство!")
                end
            end
        end
    })

    return self
end

return Alchemist
