local DamageService = require("services.DamageService")

local CharacterFactory = require("factories.CharacterFactory")

local Void = CharacterFactory.apply("Войд", "Paladin")

DamageService.apply(Void, 100, { SourceType = "Sword" })
Void:showStats()
