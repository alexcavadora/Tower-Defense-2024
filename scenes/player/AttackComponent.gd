extends Area2D
class_name  PlayerAttackComponent

func _unhandled_input(event):
	if Input.is_action_just_pressed("Attack"):
		monitoring = true
		monitorable = true
		
	else:
		monitoring = false
		monitoring = false
		



func _on_body_entered(body):
	var node = body.get_parent()
	var damage_component = node.find_child("DamageComponent")
	if damage_component:
		print(body.name)
		
	
