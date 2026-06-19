extends Control
class_name PhotoReview

@onready var tr : TextureRect = $PhotoTextureRect


func set_photo(photo : Image) -> void:
	var img_texture = ImageTexture.new()
	img_texture = img_texture.create_from_image(photo)
	tr.texture = img_texture


func _on_keep_button_pressed():
	PhotoTracker.add_photo(PhotoTracker.current_photo)


func _on_discard_button_pressed():
	pass # Replace with function body.
