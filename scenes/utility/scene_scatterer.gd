extends Node2D
class_name scene_scatterer


@export var scenes_to_scatter : Array[PackedScene]
@export var node_to_scatter_under : Node = self
@export var scatter_count : int = 10
@export var continuous_scatter : bool = false
@export var time_between : float = 3.0

var timer : Timer

@onready var shape := $Area2D/CollisionShape2D

func _ready() -> void:
	if continous_scatter:
		timer = Timer.new()
		timer.autostart = true
		timer.wait_time = time_between
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		timer.start()

func scatter(scene : PackedScene) -> void:
	var rect : Rect2 = shape.shape.get_rect()
	var mid = shape.global_position
	print(rect.position)
	var tlc = mid - rect.size / 2.0
	var brc = mid + rect.size / 2.0
	var x = randi_range(tlc.x, brc.x)
	var y = randi_range(tlc.y, brc.y)
	var target_pos = Vector2(x, y)
	var inst = scene.instantiate()
	inst.global_position = target_pos
	node_to_scatter_under.add_child(inst)

func fixed_scatter() -> void:
	pass

func continous_scatter() -> void:
	scatter(scenes_to_scatter[randi_range(0, scenes_to_scatter.size() - 1)])
	print("Scattered")

func _on_timer_timeout() -> void:
	continous_scatter()
