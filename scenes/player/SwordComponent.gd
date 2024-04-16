extends AnimatedSprite2D
class_name SwordComponent
@onready var MousePos

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MousePos = get_local_mouse_position()
	rotation += MousePos.angle()
	pass
