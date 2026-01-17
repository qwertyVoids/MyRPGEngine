local CharacterFactory = {}

function CharacterFactory.apply(name, className)
    local path = "classes.subclasses.character." .. className

    local success, class = pcall(function()
        return require(path)
    end)

    if success then
        return class.new(name)
    else
        print("CharacterFactory: Не удалось создать игрока " .. name .. ". Класса " .. className .. " не существует!")
    end
end

return CharacterFactory
