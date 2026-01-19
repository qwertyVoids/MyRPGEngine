local DamageService = require("services.DamageService")

local CharacterFactory = require("factories.CharacterFactory")
local Item = require("classes.Item")

local Void = CharacterFactory.apply("Войд", "Alchemist")

local heal = Item.new("Potion", "HealthPotion", "Small")

DamageService.apply(Void, 100, { SourceType = "Sword" })
Void:UseItem(heal)
Void:ShowStats()
