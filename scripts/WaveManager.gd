class_name Wave_Manager
extends Node
@onready var n_children = get_child_count()
@onready var waves_ready = n_children
signal waves_ended(int)
var wave=1
func _ready():
	var n_children = get_child_count()
	for i in get_children():
		i.connect('wave_ended', _on_wave_ended)
		i.connect('wave_changed', _on_wave_started)

func _on_wave_ended():
	waves_ready += 1
	if waves_ready == n_children:
		for i in get_children():
			i.status = 'idle'
		wave += 1
	emit_signal('waves_ended', wave)

func _on_wave_started(x):
	waves_ready -= 1
