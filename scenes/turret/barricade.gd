extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false
var t = 'barricade'
var cost = {
	'build': 	 10
	}
func _ready():
	$Control.connect("pressed", _on_control_pressed)
	$"../Camera2D/UI".connect('turret_selected', on_turret_selected)

func _process(delta):
	if GlobalVariables.VisibleSword:
		return
	if Input.is_action_just_pressed("click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords and t!= 'barricade':
		$CollisionShape2D.disabled = true
		
	if Input.is_action_just_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		$"../Camera2D/UI".credits += cost['build']
		queue_free()
	if ghost:
		return
		
func on_turret_selected(turret):
	t = turret
	if t != 'barricade':
		$Control.disabled = true
		$CollisionShape2D.disabled = false
	else:
		$Control.disabled = false

func _on_control_pressed():
	if t != 'barricade':
		print(t)
		$Control.disabled = true
		$CollisionShape2D.disabled = true
