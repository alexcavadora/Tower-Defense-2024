extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false
var enemies = []
var target
var rotation_speed = 0.05

func _process(_delta):
	if ghost:
		return
	if enemies != [] and target != null:
		$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, get_angle_to(target.global_position) + PI/2 , rotation_speed)
	else:
		$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, 0.0, rotation_speed)

func _unhandled_input(_event):
	if Input.is_action_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group('enemy'):
		enemies.append(body)
		target = enemies[0]


func _on_area_2d_body_exited(body):
	if body.is_in_group('enemy'):
		target = enemies[0]
		enemies.erase(body)
