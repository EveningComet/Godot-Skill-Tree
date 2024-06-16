## Stores an instance of a skill to allow upgrades.
class_name SkillInstance extends Resource

## Fired when an instanced skill is upgraded. For skills that change stats,
## this allows an easy way to do that.
signal rank_changed(instance: SkillInstance)

## The attached skill.
var skill: SkillData

var curr_rank: int = 0:
	get: return curr_rank
	set(value):
		curr_rank = value
		curr_rank = clamp(curr_rank, 0, skill.max_rank)

func _init(sd: SkillData) -> void:
	skill = sd
	if skill.is_starting_skill == true:
		curr_rank = 1

func is_max_rank() -> bool:
	return curr_rank == skill.max_rank

func upgrade() -> void:
	curr_rank += 1
	rank_changed.emit(self)

func downgrade() -> void:
	curr_rank -= 1
	rank_changed.emit(self)
