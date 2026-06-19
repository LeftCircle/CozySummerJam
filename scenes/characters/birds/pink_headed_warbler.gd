extends BaseBird
class_name PinkHeadedWarbler

@onready var anim_player = $AnimationPlayer

enum STATES {FLIGHT, LAND}
var state = STATES.FLIGHT

func _ready() -> void:
	appear()
	await get_tree().create_timer(randi_range(3, 10)).timeout
	dissappear()

func appear() -> void:
	if randf() < 0.5:
		anim_sprite.play("flight_00")
	else:
		anim_sprite.play("flight_00")
	anim_player.play("fade_in")
	await anim_player.animation_finished
	if randf() < 0.5:
		anim_sprite.play("land_00")
	else:
		anim_sprite.play("land_01")

func dissappear() -> void:
	if randf() < 0.5:
		anim_sprite.play("flight_00")
	else:
		anim_sprite.play("flight_00")
	anim_player.play_backwards("fade_in")
	await anim_player.animation_finished
	queue_free()
