extends Node
class_name BaseLevel

@export var level_name : String

func _ready():
	if level_name == "":
		push_error("UNNAMED LEVEL THIS SHOULD NEVER HAPPEN ", name)
