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
		change.emit("Run")
		Target.velocity.x = directionX * SPEED
	else:
		#change.emit("idle")
		Target.velocity.x = move_toward(Target.velocity.x, 0, SPEED)
		
	if directionY:
		change.emit("Run")
		Target.velocity.y = directionY * SPEED
	else:
		#change.emit("idle")
		Target.velocity.y = move_toward(Target.velocity.y, 0, SPEED)
	
	if directionX == 0 and directionY == 0:
		change.emit("Idle")
		
		
		
	
	Target.move_and_slide()
