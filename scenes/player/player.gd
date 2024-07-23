extends CharacterBody2D

@export var Sprite : AnimatedSprite2D
@export var Sword : AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_right"):
		Sprite.flip_h = false
		#Sword.position.x = 9
	elif Input.is_action_just_pressed("ui_left"):
		Sprite.flip_h = true
		#Sword.position.x = -9
func _killed():
	pass


func _on_unstucker_body_entered(body):
	#print(body.name)
	if body.name == "Ground":
		collision_shape_2d.set_deferred("disabled", true)


func _on_unstucker_body_exited(body):
	#print(body.name)
	if body.name == "Ground":
		collision_shape_2d.set_deferred("disabled", false)
