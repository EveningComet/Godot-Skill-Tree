## Stores the skills for a character.
class_name SkillHolder extends Resource

## The attached character used for easy access to their stats for upgrading
var char: Character

## {SkillInstance = Current Rank}.
var skills: Dictionary = {}

func _init(my_char: Character) -> void:
	char = my_char

## Return a list of all the stored skill instances.
func get_all_skills() -> Array[SkillInstance]:
	var all_skills: Array[SkillInstance] = []
	for instance: SkillInstance in skills.keys():
		all_skills.append(instance)
	return all_skills

## Return a list of skill instances that have a rank greater than 0.
func get_usable_skills() -> Array[SkillInstance]:
	var usable_skills: Array[SkillInstance] = []
	for instance in skills.keys():
		if instance.curr_rank > 0:
			usable_skills.append(instance)
	return usable_skills

## Add a collection of skills from a job.
func add_job_skills(job: Job) -> void:
	initialize_skill_instances(job.skills)

func initialize_skill_instances(new_skills: Array[SkillData]) -> void:
	for sd in new_skills:
		var skill_instance = SkillInstance.new(sd)
		skills[skill_instance] = skill_instance.curr_rank
		skill_instance.rank_changed.connect( on_skill_rank_changed )

func on_skill_rank_changed(changed_skill: SkillInstance) -> void:
	if OS.is_debug_build() == true:
		print("SkillHolder :: %s has the skill (%s) being changed to rank: %s" % [char.name, changed_skill.skill.localization_name, changed_skill.curr_rank])
	
	# Make the necessary stat changes
	var previous_rank: int = skills[changed_skill]
	var target_rank:   int = changed_skill.curr_rank
	if target_rank > previous_rank:
		pass
	elif target_rank < previous_rank:
		pass
	skills[changed_skill] = target_rank
