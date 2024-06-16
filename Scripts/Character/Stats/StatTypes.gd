## Stores values and helpers for stats.
class_name StatHelper

enum StatTypes {
	# Attributes
	Strength,
	Dexterity,
	Intelligence,
	Wisdom,
	
	# Defense / Resistances
	Defense,
	FireRes,
	WaterRes,
	EarthRes,
	AirRes,
	
	# Damage Modifiers
	FireMods,
	WaterMods,
	EarthMods,
	AirMods
}

## The different damage types that exist in the game.
enum DamageTypes {
	Regular,
	Fire,
	Water,
	Earth,
	Air,
	Pure
}

## Wrapper to work with/around resistances.
static var damage_to_res_map: Dictionary = {
	DamageTypes.Regular: StatTypes.Defense,
	DamageTypes.Fire:    StatTypes.FireRes,
	DamageTypes.Water:   StatTypes.WaterRes,
	DamageTypes.Earth:   StatTypes.EarthRes,
	DamageTypes.Air:     StatTypes.AirRes
}
