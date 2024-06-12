## Stores the skills for a character.
class_name SkillHolder extends Resource

## {SkillData = SkillInstance}.
var skills: Dictionary = {}

## Return a list of all the stored skill instances.
func get_all_skills() -> Array[SkillInstance]:
	var all_skills: Array[SkillInstance] = []
	for instance: SkillInstance in skills.values():
		all_skills.append(instance)
	return all_skills

## Return a list of skill instances that have a rank greater than 0.
func get_usable_skills() -> Array[SkillInstance]:
	var usable_skills: Array[SkillInstance] = []
	for instance in skills.values():
		if instance.curr_rank > 0:
			usable_skills.append(instance)
	return usable_skills

## Add a collection of skills from a job.
func add_job_skills(job: Job) -> void:
	for sd: SkillData in job.skills:
		var skill_instance: SkillInstance = SkillInstance.new(sd)
		skills[sd] = skill_instance
