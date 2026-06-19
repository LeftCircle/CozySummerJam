extends BaseBird
class_name FlamingoTree


func _ready() -> void:
	appear()

func appear() -> void:
	anim_sprite.play("stand")

func dissappear() -> void:
	anim_sprite.set_frame(15)
	anim_sprite.play_backwards("stand")
