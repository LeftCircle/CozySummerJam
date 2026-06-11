extends Area2D
class_name LoadLevelPortal

signal portal_entered(destination : PackedScene)

@export var destination_scene : PackedScene

func _on_body_entered(body):
	if body is Player:
		portal_entered.emit(destination_scene)
		print("Signal sent")
