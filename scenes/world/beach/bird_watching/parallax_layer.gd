extends CanvasLayer



func _ready() -> void:
	print(is_instance_valid(custom_viewport))
	set_custom_viewport(get_viewport())
