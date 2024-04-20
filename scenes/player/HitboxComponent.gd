extends Area2D
class_name HitboxComponent
@export var Target : CharacterBody2D
@export var health_component : HealthComponent
@onready var damage_component : DamageComponent
var Position

func damage(amount):
	if health_component:
		health_component.damage(amount)


func _on_body_entered(body):
	if body.find_child("DamageComponent"):
		damage_component = body.find_child("DamageComponent")
		damage(damage_component.damage)
	
