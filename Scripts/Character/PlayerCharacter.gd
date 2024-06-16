## Stores an instance of a player characeter.
class_name PlayerCharacter extends Character

@export var char_name: String = "Jim"
@export var job: Job = null

@export var class_level: int = 1
@export var available_skill_points: int = 6

func _ready() -> void:
	name = char_name
	skill_holder.add_job_skills(job)
