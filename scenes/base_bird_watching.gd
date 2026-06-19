extends Node2D

signal take_photo()
signal photo_captured(photo : Image)

@export var sprite_for_img : Sprite2D
@export var camera : Camera2D
@export var canvas_groups : Array[CanvasGroup] = []
@export var photo_size : Vector2 = Vector2(256, 256)
@export var background_size : Vector2 = Vector2(3840, 2160)

@onready var svc := $SubViewportForPhotoCapture
@onready var sv := $SubViewportForPhotoCapture/SubViewport
@onready var view_width = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var view_height = ProjectSettings.get_setting("display/window/size/viewport_height")
@onready var screen_size := Vector2(view_width, view_height)

var current_layer = 0

func _ready():
	_on_level_changed(0)
	var mat : Material = $CanvasLayer0/CanvasGroup.material
	mat.set("shader_parameter/strength", 0)
	sv.size = photo_size

func _process(delta):
	#global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("take_photo"):
		#take_photo.emit()
		#await RenderingServer.frame_post_draw
		##get_viewport().size = Vector2(48, 48)
		#var img = get_viewport().get_texture().get_image()
		#img.save_png("res://FullScreenshot.png")
		#var img_texture = ImageTexture.new()
		#img_texture = img_texture.create_from_image(img)
	#
		#sprite_for_img.texture = img_texture
		## screen_width - (mouse_position * camera.zoom) - half_screen_width + half_frame_size
		##sprite_for_img.position = screen_size - (get_global_mouse_position() * camera.zoom) - screen_size / 2.0
		##sprite_for_img.position += photo_size / 2.0
		#
		#await RenderingServer.frame_post_draw
		#var photo : Image = sv.get_texture().get_image()
		#photo.save_png("res://Screenshot.png")
		#PhotoTracker.current_photo = photo
		#photo_captured.emit(photo)
		pass

# Could clean it up following this function
#func take_screenshoot() -> void:
	## Create the SubViewport 
	#var sub_viewport = SubViewport.new()
	## Add the SubViewport to the tree
	#svc.add_child(sub_viewport)
	## Use the same World2D as the main Viewport
	#sub_viewport.world_2d = get_viewport().world_2d
	#sub_viewport.world_2d = cl.custom_viewport.world_2d
	## Set its size
	#sub_viewport.size = Vector2(512, 512)
	## We only need it to update once for the screenshoot
	#sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	## Move it to the place we want to take the screenshoot
	##sub_viewport.canvas_transform.origin = Vector2(0, 256)
	#svc.global_position = Vector2(0, -256)
	## Wait for the next frame to render
	#await RenderingServer.frame_post_draw
	## Grab the image, save it and free the SubViewport
	#var img = sub_viewport.get_texture().get_image()
	#img.save_png("res://screenshot.png")
	#sub_viewport.queue_free()
	#print("Screenshot taken")

func _on_level_changed(change : int) -> void:
	current_layer += change
	current_layer = clampi(current_layer, -3, 3)
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel(true)
	for i in range(-3, 4):
		var dist_from_current = abs(current_layer - i)
		var cg : CanvasGroup = canvas_groups[i + 3]
		if i > 0 and dist_from_current > 0:
			dist_from_current += i
		tween.tween_property(cg.material, "shader_parameter/strength", dist_from_current * 5, 1.0)
		#cg.material.set("shader_parameter/strength", dist_from_current * 5)
		print("Layer: ", i, " Blur = ", dist_from_current * 5)
		
	
