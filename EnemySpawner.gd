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

func spawn_next_wave():
	if wave > n_waves or status == 'spawning':
		return
	status = 'spawning'
	emit_signal('wave_changed', wave)
	for enemy in waves[wave]:
		await spawn_unit(enemy, waves[wave][enemy]['time'], waves[wave][enemy]['amount'])
	status = 'idle'
	wave += 1
	
	
func spawn_unit(enemy_name, time, amount):
	for i in amount:
		if enemy_name == 'zombies':
			x = zombie_scene.instantiate()
		elif enemy_name == 'slime':
			x = slime_scene.instantiate()
		elif enemy_name == 'orc':
			x = orc_scene.instantiate()
		x.startIndex = spawner_tile_index
		get_parent().add_child.call_deferred(x)
		await get_tree().create_timer(time).timeout
	
	
func _unhandled_input(_event):
	if Input.is_action_just_pressed("space"):
		spawn_next_wave()
