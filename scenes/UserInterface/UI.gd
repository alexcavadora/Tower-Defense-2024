extends Control
signal turret_selected(String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_turret_1_pressed():
	var turret1 = "MG"
	emit_signal("turret_selected", turret1)

func _on_turret_2_pressed():
	var turret2 = "missile_launcher"
	emit_signal("turret_selected", turret2)

func _on_turret_3_pressed():
	var turret3 = "cannon"
	emit_signal("turret_selected", turret3)

func _on_turret_4_pressed():
	var turret4 = "empty"
	emit_signal("turret_selected", turret4)
	
func _on_wave_changed(wave: int):
	if wave == 1:
		$TextureRect.show()
	$TextureRect/Label.text = "wave %d" % wave
func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("1"):
		_on_turret_1_pressed()
	elif Input.is_action_just_pressed("2"):
		_on_turret_2_pressed()
	elif Input.is_action_just_pressed("3"):
		_on_turret_3_pressed()
	elif Input.is_action_just_pressed("4"):
		_on_turret_4_pressed()
