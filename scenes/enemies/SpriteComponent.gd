class_name SpriteComponent

extends AnimatedSprite2D


	
func start_animation():
	play("default")

func stop_animation():
	stop()


func _on_movement_component_direction_changed(direction):
	play(direction)
