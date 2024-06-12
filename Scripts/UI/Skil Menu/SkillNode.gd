## Allows a player to interact with unlocking a particular skill.
class_name SkillNode extends Button

## The skill that this button is tied to.
@export var associated_skill: SkillData

@export_category("Visuals")
## Visual representation of what skill is stored in this button.
@export var display_icon: TextureRect

## Used to display the current rank to the player.
@export var rank_label: Label

@export var active_color:   Color = Color.WHITE
@export var inactive_color: Color = Color.WHITE

## Used to display the branches to the player.
@export var line_2d: Line2D

## The skill instance that should be paired with the attached skill.
var skill_instance: SkillInstance

func _ready() -> void:
	set_associated_skill(associated_skill)
	if get_parent() is SkillNode:
		draw_point_to(get_parent().global_position + size / 2)

func set_associated_skill(new_skill: SkillData) -> void:
	associated_skill = new_skill
	if associated_skill.is_starting_skill == true:
		rank_label.set_text("%s / %s" % [1, str(associated_skill.max_rank)])
	else:
		update_rank_label(0)
	
	display_icon.set_texture(associated_skill.display_icon)
	turn_off()

func set_instanced_skill(instance: SkillInstance) -> void:
	skill_instance = instance
	update_rank_label(skill_instance.curr_rank)

## Make the line draw to another node.
func draw_point_to(point_to: Vector2) -> void:
	line_2d.add_point(global_position + size / 2)
	line_2d.add_point(point_to)

func update_rank_label(new_rank: int) -> void:
	rank_label.set_text("%s / %s" % [str(new_rank),
		str(associated_skill.max_rank)])

func turn_off() -> void:
	disabled = true
	display_icon.self_modulate = inactive_color

func turn_on() -> void:
	disabled = false
	display_icon.self_modulate = active_color
