## Stores a collection of stat objects for the player.
class_name Stats extends Resource

## A key value pair of the stats. {StatType = Stat Object}
var stats: Dictionary = {}

## Initialize with filler stats.
func initialize() -> void:
	# Attributes
	stats[StatHelper.StatTypes.Strength]     = Stat.new(5, true)
	stats[StatHelper.StatTypes.Dexterity]    = Stat.new(5, true)
	stats[StatHelper.StatTypes.Intelligence] = Stat.new(5, true)
	stats[StatHelper.StatTypes.Wisdom]       = Stat.new(5, true)
	
	# Vitals
	stats[StatHelper.StatTypes.MaxHP]     = Stat.new(50, true)
	stats[StatHelper.StatTypes.CurrentHP] = get_max_hp()

func get_max_hp() -> int:
	return round(stats[StatHelper.StatTypes.MaxHP].get_calculated_value())

func get_max_sp() -> int:
	return round(stats[StatHelper.StatTypes.MaxSP].get_calculated_value())

func add_modifier(stat_type, mod: StatModifier) -> void:
	pass

func remove_modifier(stat_type, mod: StatModifier) -> void:
	pass
