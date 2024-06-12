## Stores an instance of a player characeter.
class_name PlayerCharacter extends Node

@export var char_name: String = "Jim"
@export var job: Job = null

@export var class_level: int = 1
@export var available_skill_points: int = 6

var skill_instance_holder: SkillInstanceHolder
