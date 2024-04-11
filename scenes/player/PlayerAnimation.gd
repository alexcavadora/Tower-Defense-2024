class_name PlayerAnimation

extends AnimatedSprite2D

func idle_animation():
	play("Idle")

func run_animation():
	play("run")

func stop_animation():
	stop()
