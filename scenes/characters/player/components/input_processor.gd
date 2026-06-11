extends Node
class_name InputProcessor

signal interact

var input_dir : Vector2
var last_nonzero_input_dir : Vector2

func _physics_process(delta):
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if not input_dir == Vector2.ZERO:
		last_nonzero_input_dir = input_dir

func get_input_dir() -> Vector2:
	return input_dir

func _unhandled_input(event : InputEvent):
	if event.is_action_pressed("interact"):
		interact.emit()
