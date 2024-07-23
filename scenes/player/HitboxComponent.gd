extends Area2D
class_name HitboxComponent
@export var Target : CharacterBody2D
@export var health_component : HealthComponent
@export var shake : ShakeComponent
@export var knock : KnockBackComponent
@onready var damage_component : DamageComponent


func damage(amount):
	if health_component:
		health_component.damage(amount)


func _on_body_entered(body):
	if body.find_child("DamageComponent"):
		knock.knock_back(body,self.get_parent())
		damage_component = body.find_child("DamageComponent")
		shake.tween_shake()
		damage(damage_component.damage)
		
	
