class_name PlayMovementComponent
extends Node2D
@export var Target : CharacterBody2D
@export var SPEED = 300.0
#const JUMP_VELOCITY = -400.0
signal change(animation)

func _physics_process(delta):
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	
	#print("Direction Y", directionY)
	#print("Direction X", directionX)

	
	if directionX:
		Target.velocity.x = directionX * SPEED
	else:
		Target.velocity.x = move_toward(Target.velocity.x, 0, SPEED)
		
	if directionY:
		Target.velocity.y = directionY * SPEED
	else:
		Target.velocity.y = move_toward(Target.velocity.y, 0, SPEED)
	
	if directionX == 0 and directionY == 0:
		change.emit("pause")
	if abs(Target.velocity.x) > abs(Target.velocity.y):
		change.emit("East")
			#if Target.velocity.x > 0:
			#	change.emit("East")
			#else:
			#	change.emit("East")
	else:
		if Target.velocity.y > 0:
			change.emit("South")
		elif  Target.velocity.y < 0:
			change.emit("North")
		else:
			change.emit("pause")
	
		
		
	
	Target.move_and_slide()
