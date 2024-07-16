extends Node2D
@onready var MousePos
@onready var GlobalMP
@export var radius = 25
@export var player : Node2D
@onready var animate = $PointLight2D/AnimatedSprite2D
@onready var timer = $Timer
@onready var light = $PointLight2D

func _ready():
	animate.play("default")

#func _process(delta):
		#var mouse_pos = get_global_mouse_position()
		#var player_pos = player.global_transform.origin 
		#var distance = player_pos.distance_to(mouse_pos) 
		#var mouse_dir = (mouse_pos-player_pos).normalized()
		#if distance > radius:
			#mouse_pos = player_pos + (mouse_dir * radius)
		#self.global_transform.origin = mouse_pos
		#MousePos = get_local_mouse_position()
		#rotation += MousePos.angle()




func _on_timer_timeout():
	light.energy = randf_range(1, 1.6)
	timer.start()
