extends AnimatedSprite2D
class_name SwordComponent
@onready var MousePos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MousePos = get_local_mouse_position()
	rotation += MousePos.angle()
	pass
