extends Node



var photos : Array[Image] = []
var current_photo : Image

func add_photo(img : Image) -> void:
	photos.append(img)
