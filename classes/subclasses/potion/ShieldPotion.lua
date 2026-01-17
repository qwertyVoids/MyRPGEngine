local Potion = require("classes.Potion")
local ShieldPotion = setmetatable({}, {__index = Potion})
ShieldPotion.__index = ShieldPotion

function ShieldPotion.new(count)
    local self = Potion.new("ShieldPotion", count)
    setmetatable(self, ShieldPotion)

    return self
end

function ShieldPotion:use(player)
    if self.Count <= 0 then
        return
    else
        self.Count = self.Count - 1
    end

    player.Modifiers.Shield.PotionEffect = 0.8
end

return ShieldPotion
