extends Node2D
@export var Anim : AnimatedSprite2D
@onready var prev

func _on_play_movement_component_change(animation):
	if animation != prev:
		prev = animation
		changeanim(animation)
	else:
		pass


func changeanim(name):
	Anim.play(name)
	print(name)
	
