local HealService = require("services.HealService")
local Potion = require("classes.Potion")
local HealthPotion = setmetatable({}, {__index = Potion})
HealthPotion.__index = HealthPotion

function HealthPotion.new(count)
    local self = Potion.new("HealthPotion", count)
    setmetatable(self, HealthPotion)

    return self
end

function HealthPotion:use(player)
    if self.Count <= 0 then
        return
    else
        self.Count = self.Count - 1
    end

    local healAmount = 15
    HealService.apply(player, healAmount, "Potion")
end

return HealthPotion
