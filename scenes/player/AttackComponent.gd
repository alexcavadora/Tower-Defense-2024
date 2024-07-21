extends Node
class_name  PlayerAttackComponent
@export var sword_component : SwordOrbComponent
@export var scale_sword : ScaleComponent
@onready var first = sword_component.find_child("Area2D")
signal attack(animation)
@export var dmg = 0
@onready var scale_enemy = $"../ScaleEnemy"




func _physics_process(delta):
	if GlobalVariables.VisibleSword == true:
		if Input.is_action_just_pressed("click"):
			scale_sword.tween_scale()
			sword_component.play("Attack")
			first.find_child("Attack").disabled=false
			#attack.emit("Attack")
			
		elif Input.is_action_just_released("click"):
			await sword_component.animation_finished
			sword_component.play("Idle")
			first.find_child("Attack").disabled=true
			#attack.emit("Idle")
	else:
		pass


func _on_area_2d_body_entered(body):
	#print(body.name)
	if body.find_child("HealthComponent"):
		var target = body.find_child("HealthComponent")
		var shakeup = body.find_child("SpriteComponent")
		scale_enemy.sprite = shakeup
		scale_enemy.tween_scale()
		target.damage(dmg)
		
		
