extends AnimatedSprite2D
class_name SwordOrbComponent
@onready var MousePos
@onready var GlobalMP
@export var radius = 25
@export var player : Node2D


func _process(delta):
	if GlobalVariables.VisibleSword == true:
		#print("Show")
		visible = true
		var mouse_pos = get_global_mouse_position()
		var player_pos = player.global_transform.origin 
		var distance = player_pos.distance_to(mouse_pos) 
		var mouse_dir = (mouse_pos-player_pos).normalized()
		if distance > radius:
			mouse_pos = player_pos + (mouse_dir * radius)
		self.global_transform.origin = mouse_pos
		MousePos = get_local_mouse_position()
		rotation += MousePos.angle()
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
