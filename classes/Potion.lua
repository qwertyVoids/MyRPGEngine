local Potion = {}
Potion.__index = Potion

function Potion.new(type, count)
    local self = setmetatable({
        Type = type,
        Count = count
    }, Potion)

    return self
end

function Potion:use()
    --TODO
end

return Potion
