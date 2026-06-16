extends Node2D
class_name ScreenShotter

@onready var subview := $SubViewport

# NOTE -> subview.get_visible_rect returns the viewports rect in screen space
# this could be used to draw the camera icons.

func _process(delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("take_photo"):
		await RenderingServer.frame_post_draw
		#get_viewport().size = Vector2(48, 48)
		get_viewport().get_texture().get_image().save_png("res://Screenshot.png")
		print("Snapped")
		#take_screenshoot()

func take_screenshoot() -> void:
	# Create the SubViewport 
	var sub_viewport = SubViewport.new()
	# Add the SubViewport to the tree
	add_child(sub_viewport)
	# Use the same World2D as the main Viewport
	sub_viewport.world_2d = get_viewport().world_2d
	# Set its size
	sub_viewport.size = Vector2(512, 512)
	# We only need it to update once for the screenshoot
	sub_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	# Move it to the place we want to take the screenshoot
	sub_viewport.canvas_transform.origin = Vector2(0, 0)
	# Wait for the next frame to render
	await RenderingServer.frame_post_draw
	# Grab the image, save it and free the SubViewport
	var img = sub_viewport.get_texture().get_image()
	img.save_png("res://screenshot.png")
	sub_viewport.queue_free()
