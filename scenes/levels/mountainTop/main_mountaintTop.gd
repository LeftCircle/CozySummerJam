extends "res://scenes/base_bird_watching.gd"
var switch_day_night = preload("mountainTop_switch_day_night.gd").new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_day_night.init(self)
	#switch_day_night.switch_to_day();
	switch_day_night.switch_to_night();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
