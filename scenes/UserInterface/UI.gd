extends Control
signal turret_selected(String)
@onready var wave_progress_bar = $"20/HBoxContainer/VBoxContainer2/WaveProgess"
@onready var health_bar = $"20/HBoxContainer/VBoxContainer2/HPBar"
@onready var credits = 100
@onready var popup_scene = preload("res://scenes/UserInterface/price_popup.tscn")
var x 
# Called when the node enters the scene tree for the first time.
func _ready():
	wave_progress_bar.min_value = 0.0
	wave_progress_bar.max_value = 0.0
	wave_progress_bar.value = 0.0
	$"20/HBoxContainer/VBoxContainer2/Credits_text".text = '%d G' % credits
	

func _on_turret_1_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	var turret1 = "barricade"
	emit_signal("turret_selected", turret1)
	GlobalVariables.VisibleSword = false
	$HBoxContainer/Turret1.grab_focus()
	$HBoxContainer/Turret1.add_child(x)
	
func _on_turret_2_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	var turret2 = "missile_launcher"
	emit_signal("turret_selected", turret2)
	GlobalVariables.VisibleSword = false
	$HBoxContainer/Turret2.grab_focus()
	$HBoxContainer/Turret2.add_child(x)
	
func _on_turret_3_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	var turret3 = "cannon"
	emit_signal("turret_selected", turret3)
	GlobalVariables.VisibleSword = false
	$HBoxContainer/Turret3.grab_focus()
	$HBoxContainer/Turret3.add_child(x)
	
func _on_turret_4_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	var turret4 = "MG"
	emit_signal("turret_selected", turret4)
	GlobalVariables.VisibleSword = false
	$HBoxContainer/Turret4.grab_focus()
	$HBoxContainer/Turret4.add_child(x)

func _on_turret_5_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	var turret5 = "medic"
	emit_signal("turret_selected", turret5)
	GlobalVariables.VisibleSword = false
	$HBoxContainer/Turret5.grab_focus()
	$HBoxContainer/Turret5.add_child(x)
	
func _on_turret_6_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	$HBoxContainer/Turret6.grab_focus()
	$HBoxContainer/Turret6.add_child(x)

func _on_turret_7_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	$HBoxContainer/Turret7.grab_focus()
	$HBoxContainer/Turret7.add_child(x)

func _on_turret_8_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	$HBoxContainer/Turret8.grab_focus()
	$HBoxContainer/Turret8.add_child(x)
func _on_turret_9_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	$HBoxContainer/Turret9.grab_focus()
	$HBoxContainer/Turret9.add_child(x)

func _on_turret_10_pressed():
	if x!= null:
		x.queue_free()
	x = popup_scene.instantiate()
	var turret10 = "empty"
	emit_signal("turret_selected", turret10)
	GlobalVariables.VisibleSword = true
	
	
func _on_wave_changed(wave: int):
	if wave == 1:
		$TextureRect.show()
	$TextureRect/Label.text = "wave %d" % wave
	wave_progress_bar.value = wave_progress_bar.value - wave_progress_bar.max_value
	wave_progress_bar.min_value = 0.0
	wave_progress_bar.max_value = 0.0

	
func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("1"):
		_on_turret_1_pressed()
		
	elif Input.is_action_just_pressed("2"):
		_on_turret_2_pressed()

	elif Input.is_action_just_pressed("3"):
		_on_turret_3_pressed()
		
	elif Input.is_action_just_pressed("4"):
		_on_turret_4_pressed()
		
	elif Input.is_action_just_pressed("5"):
		_on_turret_5_pressed()
		
	elif Input.is_action_just_pressed("6"):
		_on_turret_6_pressed()
		
	elif Input.is_action_just_pressed("7"):
		_on_turret_7_pressed()
		
	elif Input.is_action_just_pressed("8"):
		_on_turret_8_pressed()
		
	elif Input.is_action_just_pressed("9"):
		_on_turret_9_pressed()
		
	elif Input.is_action_just_pressed("0"):
		_on_turret_10_pressed()
		$HBoxContainer/Turret10.grab_focus()
	elif Input.is_action_just_pressed("Tab"):
		$HBoxContainer.visible = !$HBoxContainer.visible


func _on_spawner_node_enemy_spawned(hp: float):
	$"20/HBoxContainer/VBoxContainer2".show()
	wave_progress_bar.max_value += hp

func _on_enemy_reached_goal(dmg: float):
	health_bar.value -= dmg

func _on_enemy_died(hp: float):
	wave_progress_bar.value += hp


