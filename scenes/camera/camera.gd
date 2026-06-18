extends CharacterBody2D
class_name Camera

signal zoom(amount : int)

@export var movement : Movement

@onready var input_processor := $InputProcessor

func _physics_process(delta : float) -> void:
	velocity = movement.tick(delta, input_processor.input_dir, velocity)
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		zoom.emit(-1)
	elif Input.is_action_just_pressed("zoom_out"):
		zoom.emit(1)
