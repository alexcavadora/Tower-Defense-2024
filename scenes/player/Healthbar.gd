extends ProgressBar
class_name HealthbarComponent
@export var health_component : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = health_component.MAX_HEALTH# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = health_component.health
