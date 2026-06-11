extends CharacterBody2D
class_name Player

@export var movement : Movement

@onready var input_processor := $InputProcessor

func _physics_process(delta : float) -> void:
	velocity = movement.tick(delta, input_processor.input_dir, velocity)
	move_and_slide()
