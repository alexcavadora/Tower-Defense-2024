extends Node2D
@export var ToggleSword = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if ToggleSword == true:
		GlobalVariables.VisibleSword = true
	else:
		pass
