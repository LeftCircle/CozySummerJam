extends Node
class_name InteractionManager

@export var interactor : Node

var interactables : Array = []

func _ready():
	if not is_instance_valid(interactor):
		interactor = get_parent()

func register_interactables(interactable) -> void:
	if not interactables.has(interactable):
		interactables.append(interactable)

func remove_interacble(interactable) -> void:
	interactables.erase(interactable)

func get_closest_interactable():
	if interactables.is_empty():
		return null
	return interactables[-1]

func trigger_interaction():
	var interactable = get_closest_interactable()
	if !is_instance_valid(interactable):
		return
	interactable.on_interact(interactor)
