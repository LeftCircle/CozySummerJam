extends Area2D
class_name LoadLevelPortal

@export var destination_key : String

func _on_body_entered(body):
	if body is Player:
		LevelManager.load_new_scene(destination_key)
