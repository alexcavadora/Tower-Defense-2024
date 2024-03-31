extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		queue_free()
