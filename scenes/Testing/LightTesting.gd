extends Node2D
@onready var animation_player = $AnimationPlayer2

func _unhandled_input(event):
	if Input.is_key_label_pressed(KEY_P):
		animation_player.play("new_animation")
