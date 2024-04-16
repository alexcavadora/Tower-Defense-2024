extends Node2D
class_name HealthComponent
@export var MAX_HEALTH := 10
var health : float
var alive = true
func _ready():
	health = MAX_HEALTH

func damage_int(attack: int):
	health -= attack
	if health <= 0 and alive:
		alive = false
		get_parent()._killed()

func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		get_parent()._killed()

