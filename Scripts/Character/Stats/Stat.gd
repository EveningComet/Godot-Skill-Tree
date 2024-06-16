## Stores a value.
class_name Stat extends Resource

var base_value: float = 0.0

var modifiers: Array[StatModifier] = []

func _init(bv: float) -> void:
	base_value = bv

func add_modifier(mod: StatModifier) -> void:
	modifiers.append(mod)

func remove_modifier(mod: StatModifier) -> void:
	modifiers.erase(mod)

## Get the "true" value for this stat at a given time.
func get_calculated_value() -> float:
	var final_value: float = 0.0
	return final_value
