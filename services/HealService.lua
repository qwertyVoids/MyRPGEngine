local HealService = {}

function HealService.apply(target, healAmount, tags)
    if type(target) ~= "table" and type(healAmount) ~= "number" then
        print("HealService: Ошибка в приведённых аргументах.")
        return
    end

    local event = { amount = healAmount, tags = tags or {}, isBlocked = false }
    target:TriggerEvent("OnHeal", event)

    if not event.isBlocked then
        target:Heal(event.amount)
    end
end

return HealService
