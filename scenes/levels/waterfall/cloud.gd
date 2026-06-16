extends Sprite2D

@export var min_scale: float = 0.5
@export var max_scale: float = 1.5

var start_x: float
var random_offset: float
var random_speed: float
var time: float = 0.0

func _ready() -> void:
	var random_size: float = randf_range(min_scale, max_scale)
	scale = Vector2(random_size, random_size)
	start_x = position.x
	random_offset = randf_range(0.0, 30.0)
	random_speed = randf_range(0.08, 0.2)


func _process(delta: float) -> void:
	time += delta * random_speed;
	position.x = start_x + sin(time + random_offset) * 100;
