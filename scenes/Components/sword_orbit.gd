
extends Node2D
class_name SwordOrbComponent

@export var target : Node2D
@onready var MousePos = get_local_mouse_position()
@onready var GlobalPlayer = player.position
@onready var mouse_pos
@onready var player_pos
@export var radius = 25
@export var speed_factor = 6
@export var player : Node2D

func _draw():
	#draw_line(Vector2(0,0), MousePos,Color.WHITE)
	pass

func _process(delta):
	if GlobalVariables.VisibleSword == true:
		visible = true
		GlobalPlayer = player.global_position
		MousePos = get_local_mouse_position()
		target.rotation += MousePos.angle()*(delta*speed_factor)
		#print("Show")
		mouse_pos = get_global_mouse_position()
		player_pos = player.global_transform.origin 
		var distance = player_pos.distance_to(mouse_pos) 
		var mouse_dir = (mouse_pos-player_pos).normalized()
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		target.global_transform.origin = mouse_pos
		queue_redraw()

		#GlobalMP = get_global_mouse_position()
		#position += (GlobalMP - position)*(delta*3)
		#position.x = clamp(position.x, -20, 20)
		#position.y = clamp(position.y, -20, 20)
		
	elif GlobalVariables.VisibleSword == false:
		#print("Hide")
		visible = false


func _on_play_movement_component_change(animation):
	if animation == "North":
		z_index = -1
	elif animation == "South":
		z_index = 0
