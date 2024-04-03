extends Control
signal turret_selected(String)
@onready var wave_progress_bar = $"20/HBoxContainer/VBoxContainer2/WaveProgess"
@onready var health_bar = $"20/HBoxContainer/VBoxContainer2/HPBar"
# Called when the node enters the scene tree for the first time.
func _ready():
	wave_progress_bar.min_value = 0
	wave_progress_bar.max_value = 0
	wave_progress_bar.value = 0
	

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
	wave_progress_bar.value = wave_progress_bar.value-wave_progress_bar.max_value
	wave_progress_bar.min_value = 0
	wave_progress_bar.max_value = 0

	
func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("1"):
		_on_turret_1_pressed()
	elif Input.is_action_just_pressed("2"):
		_on_turret_2_pressed()
	elif Input.is_action_just_pressed("3"):
		_on_turret_3_pressed()
	elif Input.is_action_just_pressed("4"):
		_on_turret_4_pressed()


func _on_spawner_node_enemy_spawned(hp: int):
	$"20/HBoxContainer/VBoxContainer2".show()
	wave_progress_bar.max_value += hp

func _on_enemy_reached_goal(dmg: int):
	health_bar.value -= dmg

func _on_enemy_died(hp: int):
	wave_progress_bar.value += hp
