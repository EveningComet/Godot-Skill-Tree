## Stores an instance of a skill tree.
class_name SkillTree extends Control
# TODO: Rename this to be something more generic and reusable?

var skill_menu: SkillMenu
var existing_skill_nodes: Array[SkillNode]

func _ready() -> void:
	existing_skill_nodes = get_all_existing_nodes_within()

## A quick and dirty way of getting all the skill nodes attached to a skill tree.
func get_all_existing_nodes_within(branch: Control = self) -> Array[SkillNode]:
	var all_contained_skill_nodes: Array[SkillNode] = []
	for n in branch.get_children():
		if n is SkillNode:
			all_contained_skill_nodes.append(n)
		if n.get_child_count() > 0:
			all_contained_skill_nodes.append_array( get_all_existing_nodes_within(n) )
	return all_contained_skill_nodes

## Taking a collection of instanced skills, hook them up with the correct skill.
func combine_instances_to_nodes(instanced_skills: Array[SkillInstance]) -> void:
	var temp: Array[SkillNode]
	temp.append_array(existing_skill_nodes)
	if OS.is_debug_build() == true:
		print("SkillTree :: %s has a total node skill node count of: %s" %[name, existing_skill_nodes.size()])
		
	for instance: SkillInstance in instanced_skills:
		for n in temp:
			if instance.skill == n.associated_skill:
				n.set_instanced_skill(instance)
				temp.erase(n)
				continue

## Go through the stored nodes and see which ones can accept upgrades.
func update_upgradability_status(char: PlayerCharacter) -> void:
	var available_skill_points: int = char.available_skill_points
	for n: SkillNode in existing_skill_nodes:
		if n.associated_skill.is_starting_skill == true:
			n.turn_on()
		if n.get_parent() is SkillNode:
			var parent_n: SkillNode = n.get_parent()
			if parent_n.skill_instance.curr_rank >= n.associated_skill.minimum_rank_of_previous:
				n.turn_on()
			else:
				n.turn_off()
