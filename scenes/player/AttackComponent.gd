extends Node
class_name  PlayerAttackComponent
@export var sword_component : SwordComponent
@onready var first = sword_component.find_child("Area2D")
signal attack(animation)


func _unhandled_input(event):
	if Input.is_action_just_pressed("Attack"):
		sword_component.play("Attack")
		first.find_child("Attack").disabled=false
		#attack.emit("Attack")
		
	elif Input.is_action_just_released("Attack"):
		await sword_component.animation_finished
		sword_component.play("Idle")
		first.find_child("Attack").disabled=true
		#attack.emit("Idle")





func _on_area_2d_body_entered(body):
	print(body.name)
