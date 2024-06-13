## Responsible for handling upgrades in the skill menu.
class_name SkillMenuUpgradeHandler extends Node

var curr_character: PlayerCharacter ## The current character.
var skill_tree:     SkillTree       ## The current skill tree.

var draft_points:   int = 0

func set_character(new_char: PlayerCharacter) -> void:
	curr_character = new_char
	draft_points   = curr_character.available_skill_points

func set_skill_tree(new_skill_tree: SkillTree) -> void:
	skill_tree = new_skill_tree

func on_skill_upgraded(skill_node: SkillNode) -> void:
	# TODO: Check which nodes have to be locked/unlocked due to the upgrade.
	pass
