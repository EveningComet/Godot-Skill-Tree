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

## Used as the temporary skill points for when the player is selecting upgrades.
var draft_points: int = 0

## The current skill tree.
var skill_tree: SkillTree

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
	draft_points = curr_character.available_skill_points
	update_displayed_job(curr_character.job)
	undo_skill_points_button.disabled = draft_points == 0
	update_available_skill_points_display(draft_points)

func update_displayed_job(new_job: Job) -> void:
	# TODO: Delete the previously spawned tree before spawning the new one.
	skill_tree = new_job.skill_tree_prefab.instantiate()
	skill_tree_holder.add_child(skill_tree)
	
	# Hook up the skills and subscribe to relevant events
	skill_tree.combine_instances_to_nodes(curr_character.skill_holder.get_all_skills())
	skill_tree.update_upgradability_status(curr_character)
	hookup_upgrade_nodes()

func on_undo_skill_points_button_pressed() -> void:
	# Go through the alloted history and undo the upgrades the player made
	while alloted_history.is_empty() == false:
		var upgrade_to_remove = alloted_history.pop_back()

func hookup_upgrade_nodes() -> void:
	var existing_skill_nodes = skill_tree.existing_skill_nodes
	for n: SkillNode in existing_skill_nodes:
		n.upgraded.connect( on_upgrade_occurred )

## Handle what should happen when an upgrade happens here.
func on_upgrade_occurred(ui_upgradable) -> void:
	if draft_points == 0:
		return
	
	draft_points -= 1
	if draft_points < 0:
		draft_points = 0
	update_available_skill_points_display(draft_points)

func update_available_skill_points_display(new_value: int) -> void:
	skill_points_value_label.set_text( str(new_value) )
