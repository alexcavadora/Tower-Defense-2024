extends Node2D
var once = 0 

# Called when the node enters the scene tree for the first time.


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept") and $Camera2D/Dialogue_test.line == 4 and once == 0:
		$AnimationPlayer.play("De-Dark")
		#await $AnimationPlayer.animation_finished()
		$AnimationPlayer/AnimatedSprite2D.play("default")
		once += 1
		
