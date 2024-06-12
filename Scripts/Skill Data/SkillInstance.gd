## Stores an instance of a skill to allow upgrades.
class_name SkillInstance extends Resource

## The attached skill.
var skill: SkillData

var curr_rank: int = 0

func _init(sd: SkillData) -> void:
	skill = sd
	if skill.is_starting_skill == true:
		curr_rank = 1
