extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false

func _process(delta):
	if GlobalVariables.VisibleSword:
		return

	if Input.is_action_just_pressed("click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		$CollisionShape2D.disabled = true

	if Input.is_action_just_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		queue_free()
	if ghost:
		return
