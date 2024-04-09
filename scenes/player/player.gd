extends CharacterBody2D

@onready var movement_component = $PlayMovementComponent
@onready var player_animation = $PlayerAnimation
signal anim_change

func _ready():
	pass

