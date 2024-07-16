extends PointLight2D
@onready var timer = $Timer
@onready var animated_sprite_2d = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _on_timer_timeout():
	energy = randf_range(1.5,2)
	timer.start()
