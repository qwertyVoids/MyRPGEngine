local Character = require("classes.Character")
local Paladin = setmetatable({}, {__index = Character})
Paladin.__index = Paladin

function Paladin.new(name)
    local self = Character.new(name, "Paladin")
    setmetatable(self, Paladin)

    self.MaxHealth = self.MaxHealth * 1.5
    self.Health = self.MaxHealth

    table.insert(self.Modifiers, {
        name = "Shield",
        mult = 0.5,
        OnIncomingDamage = function(mod, event, owner)
            if next(event.tags) ~= nil then
                if type(event.amount) == "number" then
                    local oldAmount = event.amount
                    event.amount = event.amount * mod.mult
                    print(owner.Name .. " поглотил " .. oldAmount - event.amount .. " единиц урона!")
                end
            end
        end
    })

    return self
end

return Paladin
