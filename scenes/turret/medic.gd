
extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false
var heal_amount = 5
var inside = null
var lvl = 0
@export var n = ''
@export var cost = {
	'build': 	 50,
	'upgrade 1': 150,
	'upgrade 2': 350
}
func _process(delta):
	if GlobalVariables.VisibleSword:
		return
	if Input.is_action_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		$"../Camera2D/UI".credits += cost['build']
		queue_free()
	if ghost:
		return
	if inside != null:
		#print('Healing!')
		inside.find_child('HealthComponent').health += heal_amount * delta

func _on_collision_shape_2d_body_entered(body):
	if body.name == 'Player':
		if body.find_child('HealthComponent').health < body.find_child('HealthComponent').MAX_HEALTH:
			inside = body
		else:
			inside = null


func _on_collision_shape_2d_body_exited(body):
	if body.name == 'Player':
		inside = null


func _on_upgraded_animation_finished():
	$Upgraded.hide()
	$Upgraded.pause()

	
func _ready():
	$Control.connect("pressed", _on_control_pressed)
	$"../Camera2D/UI".connect('turret_selected', on_turret_selected)

func on_turret_selected(turret):
	if turret == n:
		$Control.disabled = false
	else:
		$Control.disabled = true

func _on_control_pressed():
	if lvl < 2:
		lvl += 1
		heal_amount += 5
		$AnimatedSprite2D.frame = lvl
		$Upgraded.show()
		$Upgraded.frame = 0
		$Upgraded.play()

