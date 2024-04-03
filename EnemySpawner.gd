class_name spawnerNode
extends Node

var slime_scene = preload("res://scenes/enemies/slime.tscn")
var zombie_scene = preload("res://scenes/enemies/zombie.tscn")
var orc_scene = preload("res://scenes/enemies/orc.tscn")
var x = null
var enemies = [slime_scene, zombie_scene, orc_scene]
var wave = 1
var status = 'idle'
signal wave_changed(int)
<<<<<<< Updated upstream
@export var spawner_tile_index = 0
@export var waves = {
	1 : 
	{ 
		'orc':
		{
			'amount' : 2, 'time' : 3
		}
	},
	2 : 
	{
		'orc':
		{
			'amount' : 4, 'time' : 3
		},
		'zombies':
		{
			'amount' : 2, 'time' : 4
		}
	},
	3 : 
	{
		'zombies' :
		{ 
			'amount' : 3, 'time' : 2
		},
		'orc':
		{
			'amount' : 3, 'time' : 2
		},
		'slime' :
		{ 
			'amount' : 3, 'time' : 2
		},
	},
}
var n_waves = waves.size()
=======
signal wave_ended()
signal enemy_spawned(int)
@export var spawner_tile_index = 0
@export var enemy_data: Array[Wave]
@onready var n_waves = enemy_data.size()
>>>>>>> Stashed changes

func spawn_next_wave():
	if wave > n_waves or status == 'spawning':
		return
	status = 'spawning'
	emit_signal('wave_changed', wave)
<<<<<<< Updated upstream
	for enemy in waves[wave]:
		await spawn_unit(enemy, waves[wave][enemy]['time'], waves[wave][enemy]['amount'])
	status = 'idle'
=======
	for enemy_sequence in enemy_data[wave-1].enemy_sequences:
		await spawn_unit(enemy_sequence.name, enemy_sequence.time, enemy_sequence.amount)
	emit_signal('wave_ended')
>>>>>>> Stashed changes
	wave += 1
	
	
func spawn_unit(enemy_name, time, amount):
	for i in amount:
		if enemy_name == 'zombie':
			x = zombie_scene.instantiate()
		elif enemy_name == 'slime':
			x = slime_scene.instantiate()
		elif enemy_name == 'orc':
			x = orc_scene.instantiate()
		x.startIndex = spawner_tile_index
		get_parent().get_parent().add_child.call_deferred(x)
		emit_signal('enemy_spawned', 2)
		await get_tree().create_timer(time).timeout
	
	
func _unhandled_input(_event):
	if Input.is_action_just_pressed("space"):
		print(status)
		spawn_next_wave()
