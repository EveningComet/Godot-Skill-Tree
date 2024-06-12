## Data for a class that a player character can be.
class_name Job extends Resource

@export var localization_name: String = "New Job"
@export_multiline var localization_description: String = "New description."

## Template for the skill tree associated with this job.
@export var skill_tree_prefab: PackedScene
