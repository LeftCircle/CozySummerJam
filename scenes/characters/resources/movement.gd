extends Resource
class_name Movement

@export_range(100, 10000) var speed = 100;
@export_range(100, 10000) var acceleration = 1500;
@export_range(2000, 10000) var decceleration = 5000;


func tick(delta : float, input_dir : Vector2, vel : Vector2) -> Vector2:
	var a : float = 0
	if abs(input_dir.length_squared()) < 0.001 or input_dir.dot(vel) < 0:
		a = decceleration
	else:
		a = acceleration
	return vel.move_toward(input_dir * speed, a * delta)
