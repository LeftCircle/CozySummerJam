extends CharacterBody2D
class_name Camera

signal zoom(amount : int)

@export var movement : Movement
@export var sprite_for_img : Sprite2D
@export var photo_size : Vector2 = Vector2(512, 512)

var overlapping_birds : Array[BaseBird]

@onready var input_processor := $InputProcessor
@onready var anim_player := $AnimationPlayer
@onready var ui = $Sprite2D
@onready var camera := $Camera2D
@onready var photo_review_ui : PhotoReview = $Control/PhotoReview

@onready var svc := $SubViewportForPhotoCapture
@onready var sv := $SubViewportForPhotoCapture/SubViewport

func _ready() -> void:
	sv.size = photo_size


func _physics_process(delta : float) -> void:
	velocity = movement.tick(delta, input_processor.input_dir, velocity)
	move_and_slide()

func _process(delta):
	if Input.is_action_just_pressed("zoom_in"):
		adjust_zoom(-1)
	elif Input.is_action_just_pressed("zoom_out"):
		adjust_zoom(1)
	if Input.is_action_just_pressed("take_photo"):
		_take_photo()

func _take_photo() -> void:
	_on_photo_taken()
	await RenderingServer.frame_post_draw
	#get_viewport().size = Vector2(48, 48)
	var img = get_viewport().get_texture().get_image()
	img.save_png("res://FullScreenshot.png")
	var img_texture = ImageTexture.new()
	img_texture = img_texture.create_from_image(img)

	sprite_for_img.texture = img_texture
	
	await RenderingServer.frame_post_draw
	var photo : Image = sv.get_texture().get_image()
	photo.save_png("res://Screenshot.png")
	PhotoTracker.current_photo = photo
	_on_photo_captured(photo)

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
	

func _on_photo_review_finished() -> void:
	photo_review_ui.hide()
	set_physics_process(true)
	set_process(true)

func _on_photo_captured(photo : Image) -> void:
	set_physics_process(false)
	set_process(false)
	photo_review_ui.show()
	photo_review_ui.set_photo(photo)
	photo_review_ui.add_birds(overlapping_birds)

func _on_bird_area_area_entered(area):
	if area.get_parent() is BaseBird:
		overlapping_birds.append(area.get_parent())
		print("Found overlapping bird!!")

func _on_bird_area_area_exited(area):
	overlapping_birds.erase(area.get_parent())
