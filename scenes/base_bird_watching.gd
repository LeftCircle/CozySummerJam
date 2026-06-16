extends Node2D

@export var cl : CanvasLayer
@onready var svc := $SubViewportContainer
@export var sprite_for_img : Sprite2D
@export var camera : Camera2D

func _process(delta):
	#global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("take_photo"):
		await RenderingServer.frame_post_draw
		#get_viewport().size = Vector2(48, 48)
		var img = get_viewport().get_texture().get_image()
		img.save_png("res://FullScreenshot.png")
		var img_texture = ImageTexture.new()
		img_texture = img_texture.create_from_image(img)
		# The image loads in centered at screen_w / 2, screen_h / 2. 
		# Just translate it based on where the mouse is and it will save
		# by - mouse_pos / 2
		
		# Might be able to set this into a different viewport, then
		# take a screenshot of it again to save the final image. 
		# Have to set the size of the sprite to inverse the scale of the camera
		sprite_for_img.texture = img_texture
		sprite_for_img.position = Vector2(1152, 648) - (get_global_mouse_position() * camera.zoom) - Vector2(1152, 648) / 2.0
		sprite_for_img.position += Vector2(64, 64)
		print(get_global_mouse_position())
		print(Vector2(1152, 648) / camera.zoom)
		#sprite_for_img.scale = Vector2.ONE / camera.zoom
		#sprite_for_img.region_enabled = true
		#var mp : Vector2 = get_global_mouse_position()
		#sprite_for_img.region_rect = Rect2(0, 0, 1158, 648)
		await RenderingServer.frame_post_draw
		$SubViewportContainer/SubViewport.get_texture().get_image().save_png("res://Screenshot.png")

		#print("Snapped")
		#take_screenshoot()

func take_screenshoot() -> void:
	# Create the SubViewport 
	var sub_viewport = SubViewport.new()
	# Add the SubViewport to the tree
	svc.add_child(sub_viewport)
	# Use the same World2D as the main Viewport
	sub_viewport.world_2d = get_viewport().world_2d
	sub_viewport.world_2d = cl.custom_viewport.world_2d
	# Set its size
	sub_viewport.size = Vector2(512, 512)
	# We only need it to update once for the screenshoot
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	# Move it to the place we want to take the screenshoot
	#sub_viewport.canvas_transform.origin = Vector2(0, 256)
	svc.global_position = Vector2(0, -256)
	# Wait for the next frame to render
	await RenderingServer.frame_post_draw
	# Grab the image, save it and free the SubViewport
	var img = sub_viewport.get_texture().get_image()
	img.save_png("res://screenshot.png")
	sub_viewport.queue_free()
	print("Screenshot taken")
