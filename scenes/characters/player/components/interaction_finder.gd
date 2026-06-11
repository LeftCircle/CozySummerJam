extends Area2D
class_name InteractionFinder

signal interact_area(area : Area2D)
signal interact_body(body : Node2D)
signal remove_area(area : Area2D)
signal remove_body(body : Node2D)

@export var group_to_search_for : String = "Interactables"

func _on_area_entered(area : Area2D):
	if area.is_in_group(group_to_search_for):
		interact_area.emit(area)
		print("Interact area signal emitted")

func _on_body_entered(body : Node2D):
	if body.is_in_group(group_to_search_for):
		interact_body.emit(body)
		print("Interact body signal emitted")


func _on_area_exited(area):
	if area.is_in_group(group_to_search_for):
		remove_area.emit(area)

func _on_body_exited(body):
	if body.is_in_group(group_to_search_for):
		remove_body.emit(body)
