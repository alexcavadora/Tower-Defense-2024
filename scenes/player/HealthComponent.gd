extends Node2D
class_name HealthComponent
@export var MAX_HEALTH := 10
@export var Target : CharacterBody2D
var health : float
@export var healthbar : HealthbarComponent
func _ready():
	health = MAX_HEALTH

func damage(amount_dam):
	healthbar.show()
	health -= amount_dam
	if health <= 0:
		Target._killed()

