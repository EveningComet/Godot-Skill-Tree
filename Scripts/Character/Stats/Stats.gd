## Stores a collection of stat objects for the player.
class_name Stats extends Resource

## A key value pair of the stats. {StatType = Stat Object}
var stats: Dictionary = {}

func add_modifier(stat_type, mod: StatModifier) -> void:
	pass

func remove_modifier(stat_type, mod: StatModifier) -> void:
	pass
