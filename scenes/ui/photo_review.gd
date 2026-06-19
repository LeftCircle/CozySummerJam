extends Control
class_name PhotoReview

@export var bird_found_text = [
	"Well would you look at that ",
	"That just might be a ",
	"Looks like you found a",
	"A wild bird in it's natural habitiat. A ",
	"Now that's one good looking "
]

@onready var tr : TextureRect = $PhotoTextureRect
@onready var description_container := $DescriptionContainer

func set_photo(photo : Image) -> void:
	var img_texture = ImageTexture.new()
	img_texture = img_texture.create_from_image(photo)
	tr.texture = img_texture

func _clear_description_container() -> void:
	for child in description_container.get_children():
		child.queue_free()

func add_birds(birds : Array[BaseBird]) -> void:
	if birds.is_empty():
		var label = Label.new()
		label.text = "No birds present!"
		description_container.add_child(label)
	else:
		for bird in birds:
			var label = Label.new()
			var preamble = bird_found_text[randi_range(0, bird_found_text.size() - 1)]
			label.text = preamble + bird.bird_name + "!"
			description_container.add_child(label)

func _on_keep_button_pressed():
	PhotoTracker.add_photo(PhotoTracker.current_photo)


func _on_discard_button_pressed():
	pass # Replace with function body.
