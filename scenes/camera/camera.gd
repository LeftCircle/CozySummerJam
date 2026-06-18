extends CharacterBody2D
class_name Camera

signal zoom(amount : int)

@export var movement : Movement

@onready var input_processor := $InputProcessor
@onready var anim_player := $AnimationPlayer
@onready var ui = $Sprite2D
@onready var camera := $Camera2D

func _physics_process(delta : float) -> void:
	velocity = movement.tick(delta, input_processor.input_dir, velocity)
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		adjust_zoom(-1)
	elif Input.is_action_just_pressed("zoom_out"):
		adjust_zoom(1)

func adjust_zoom(amount : int) -> void:
	zoom.emit(amount)
	anim_player.play("adjust_zoom")
	#if amount > 0:
		#camera.zoom *= 0.9
	#else:
		#camera.zoom *= 1.1


func _on_photo_taken() -> void:
	ui.hide()
	await get_tree().process_frame
	await get_tree().process_frame
	ui.show()
