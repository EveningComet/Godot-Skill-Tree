## Houses a menu that will be used to display a particular character's skills.
class_name SkillMenu extends Control

## The current character the player is inspecting in the skill menu.
@export var curr_character: PlayerCharacter

## The node that will house a spawned skill tree.
@export var skill_tree_holder: Control

@export var skill_points_value_label: Label

## When the player clicks this button, and they have not confirmed anything,
## reset the used skill points.
@export var undo_skill_points_button: Button

## Stores the recent history of the skill points the player has alloted.
var alloted_history: Array = []

func _ready() -> void:
	setup()
	if curr_character != null:
		update_character_to_manage(curr_character)

func setup() -> void:
	undo_skill_points_button.pressed.connect( on_undo_skill_points_button_pressed )

func update_character_to_manage(new_char: PlayerCharacter) -> void:
	curr_character = new_char
	update_displayed_job(curr_character.job)
	undo_skill_points_button.disabled = curr_character.available_skill_points == 0
	skill_points_value_label.set_text( str(curr_character.available_skill_points) )
	if OS.is_debug_build() == true:
		print("SkillMenu :: New character to display. Updating.")

func update_displayed_job(new_job: Job) -> void:
	# TODO: Delete the previously spawned tree before spawning the new one.
	var skill_tree: SkillTree = new_job.skill_tree_prefab.instantiate()
	skill_tree_holder.add_child(skill_tree)

func on_undo_skill_points_button_pressed() -> void:
	# Go through the alloted history and undo the upgrades the player made
	while alloted_history.is_empty() == false:
		var upgrade_to_remove = alloted_history.pop_back()

func on_skill_tree_node_pressed(st_node: SkillNode) -> void:
	pass
