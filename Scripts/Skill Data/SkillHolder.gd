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
	# Make the necessary stat changes
	var previous_rank: int = skills[changed_skill]
	var target_rank:   int = changed_skill.curr_rank
	var tiers: Array[SkillTier] = changed_skill.skill.tiers
	if target_rank > previous_rank:
		print("SkillHolder :: Target rank is: ", target_rank)
		for i in range(0, target_rank):
			var tier: SkillTier = changed_skill.skill.tiers[i]
			if tier.stat_modifiers.size() > 0:
				for mod: StatModifier in tier.stat_modifiers:
					char.stats.remove_modifier(mod.stat_changing, mod)
		
		# Apply the proper stat upgrade
		var curr_tier: SkillTier = changed_skill.skill.get_tier(target_rank)
		if curr_tier.stat_modifiers.size() > 0:
			for mod: StatModifier in curr_tier.stat_modifiers:
				char.stats.add_modifier(mod.stat_changing, mod)
	
	elif target_rank < previous_rank:
		var total_tiers: int = changed_skill.skill.tiers.size()
		var i: int = total_tiers - 1
		while i >= target_rank:
			var tier: SkillTier = tiers[i]
			if tier.stat_modifiers.size() > 0:
				for mod: StatModifier in tier.stat_modifiers:
					char.stats.remove_modifier(mod.stat_changing, mod)
			i -= 1
		
		# Apply the proper stat change
		
	skills[changed_skill] = target_rank
