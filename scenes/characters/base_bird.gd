extends Node2D
class_name BaseBird

@export var bird_name : String

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Virtual functions to be overridden
func appear() -> void:
	pass

func dissappear() -> void:
	pass

func _on_animation_finished() -> void:
	#anim_sprite.stop()
	pass


func _on_animated_sprite_2d_animation_looped():
	#anim_sprite.stop()
	pass
