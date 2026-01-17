local HealthPotion = require("classes.subclasses.potion.HealthPotion")
local ShieldPotion = require("classes.subclasses.potion.ShieldPotion")

local DamageService = require("services.DamageService")

local CharacterFactory = require("factories.CharacterFactory")

local Void = CharacterFactory.apply("Войд", "Paladin")

DamageService.apply(Void, 100, { SourceType = "Sword" })
Void:showStats()


--local heal = HealthPotion.new(2)
--local shield = ShieldPotion.new(2)
--heal:use(Void)
--shield:use(Void)
--print("Количество зелий лечения: " .. heal.Count .. ";")
--print("Количество зелий защиты: " .. shield.Count .. ";")
