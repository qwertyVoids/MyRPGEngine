local DamageService = {}

function DamageService.apply(target, damage, tags)
    if type(target) ~= "table" and type(damage) ~= "number" then
        print("DamageService: Ошибка в приведённых аргументах.")
        return
    end

    local event = { amount = damage, tags = tags or {}, isBlocked = false }
    target:TriggerEvent("OnIncomingDamage", event)

    if not event.isBlocked then
        target:TakeDamage(event.amount)
    end
end

return DamageService
