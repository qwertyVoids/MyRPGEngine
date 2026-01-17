local Character = require("classes.Character")
local Alchemist = setmetatable({}, {__index = Character})
Alchemist.__index = Alchemist

function Alchemist.new(name)
    local self = Character.new(name, "Alchemist")
    setmetatable(self, Alchemist)

    table.insert(self.Modifiers, {
        name = "AlchemistMastery",
        mult = 2,
        OnStatCalculate = function(mod, event, owner)
            if next(event.tags) ~= nil then
                if event.tags.SourceType == "Potion" and event.tags.isPositive then
                    event.amount = event.amount * mod.mult
                    print("Алхимик " .. owner.Name .. " выпил зелье и сработало его мастерство!")
                end
            end
        end
    })

    return self
end

return Alchemist
