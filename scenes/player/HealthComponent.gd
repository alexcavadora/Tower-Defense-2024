extends Node2D
class_name HealthComponent
@export var MAX_HEALTH := 10
var health : float

func _ready():
	health = MAX_HEALTH

func damage(amount_dam):
	health -= amount_dam
	if health <= 0:
		get_parent().queue_free()

