extends AnimatedSprite2D
class_name SwordComponent
@onready var MousePos
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.VisibleSword == true:
		#print("Show")
		visible = true
		MousePos = get_local_mouse_position()
		rotation += MousePos.angle()
		
	elif GlobalVariables.VisibleSword == false:
		#print("Hide")
		visible = false
