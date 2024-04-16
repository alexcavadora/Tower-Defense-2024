extends CharacterBody2D
@export var Sprite : AnimatedSprite2D
@export var Sword : AnimatedSprite2D

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_right"):
		Sprite.flip_h = false
		Sword.position.x = 9
	elif Input.is_action_just_pressed("ui_left"):
		Sprite.flip_h = true
		Sword.position.x = -9
		
