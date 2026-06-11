extends Node

@export var level_transitions : Dictionary[String, PackedScene] = {}

func load_new_scene(scene : String) -> void:
	get_tree().unload_current_scene()
	get_tree().call_deferred("change_scene_to_packed", level_transitions[scene])
