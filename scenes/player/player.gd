extends CharacterBody2D

@onready var movement_component = $PlayMovementComponent
@onready var player_animation = $PlayerAnimation

func _ready():
	player_animation.start_animation()
	pass



