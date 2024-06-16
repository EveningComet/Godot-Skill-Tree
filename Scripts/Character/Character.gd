## Base class for a character in the game world.
class_name Character extends Node

var stats: Stats = Stats.new()
var skill_holder: SkillHolder = SkillHolder.new(self)
