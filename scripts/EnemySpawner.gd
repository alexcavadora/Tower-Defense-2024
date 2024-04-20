class_name spawnerNode
extends Node
var slime_scene = preload("res://scenes/enemies/slime.tscn")
var zombie_scene = preload("res://scenes/enemies/zombie.tscn")
var orc_scene = preload("res://scenes/enemies/orc.tscn")
var ixpuxtequi = preload("res://scenes/enemies/ixpuxtequi.tscn")
var ahuizol = preload("res://scenes/enemies/ahuizol.tscn")
var aluxe1 = preload("res://scenes/enemies/aluxe1.tscn")
var aluxe2 = preload("res://scenes/enemies/aluxe2.tscn")
var aluxe3 = preload("res://scenes/enemies/aluxe3.tscn")
var way_chivo = preload("res://scenes/enemies/Way_chivo.tscn")
var pre_way_chivo = preload("res://scenes/enemies/pre_way_chivo.tscn")

var mixeca1 = preload("res://scenes/enemies/mixtexca_1.tscn")
var mixeca2 = preload("res://scenes/enemies/mixtexca_2.tscn")
var mixeca3 = preload("res://scenes/enemies/mixtexca_3.tscn")
var mixeca4 = preload("res://scenes/enemies/mixtexca_4.tscn")
var mixeca5 = preload("res://scenes/enemies/campesino_1.tscn")
var mixeca6 = preload("res://scenes/enemies/campesino_2.tscn")
var mixeca7 = preload("res://scenes/enemies/campesino_3.tscn")
var mixeca8 = preload("res://scenes/enemies/campesino_4.tscn")

var x = null
var enemies = [slime_scene, zombie_scene, orc_scene]
var wave = 1
var status = 'idle'
signal wave_changed(int)
signal wave_ended()
signal enemy_spawned(int)
@export var spawner_tile_index = 0
@export var enemy_data: Array[Wave]
@onready var n_waves = enemy_data.size()

func spawn_next_wave():
	if wave > n_waves or status == 'spawning':
		return
	status = 'spawning'
	emit_signal('wave_changed', wave)
	for enemy_sequence in enemy_data[wave-1].enemy_sequences:
		await spawn_unit(enemy_sequence.name, enemy_sequence.time, enemy_sequence.amount)
	emit_signal('wave_ended')
	wave += 1

func spawn_unit(enemy_name, time, amount):
	for i in amount:
		if enemy_name == 'zombie':
			x = zombie_scene.instantiate()
		elif enemy_name == 'slime':
			x = slime_scene.instantiate()
		elif enemy_name == 'orc':
			x = orc_scene.instantiate()
		elif enemy_name == 'ixpuxtequi':
			x = ixpuxtequi.instantiate()
		elif enemy_name == 'ahuizol':
			x = ahuizol.instantiate()
		elif enemy_name == 'aluxe1':
			x = aluxe1.instantiate()
		elif enemy_name == 'aluxe2':
			x = aluxe2.instantiate()
		elif enemy_name == 'aluxe3':
			x = aluxe3.instantiate()
		elif enemy_name == 'way_chivo':
			x = way_chivo.instantiate()
		elif enemy_name == 'pre_way_chivo':
			x = pre_way_chivo.instantiate()
		elif enemy_name == 'mixeca1':
			x = mixeca1.instantiate()
		elif enemy_name == 'mixeca2':
			x = mixeca2.instantiate()
		elif enemy_name == 'mixeca3':
			x = mixeca3.instantiate()
		elif enemy_name == 'mixeca4':
			x = mixeca4.instantiate()
		elif enemy_name == 'mixeca5':
			x = mixeca5.instantiate()
		elif enemy_name == 'mixeca6':
			x = mixeca6.instantiate()
		elif enemy_name == 'mixeca7':
			x = mixeca7.instantiate()
		elif enemy_name == 'mixeca8':
			x = mixeca8.instantiate()

		x.startIndex = spawner_tile_index
		get_parent().get_parent().add_child.call_deferred(x)
		emit_signal('enemy_spawned', x.find_child("HealthComponent").MAX_HEALTH)
		#print('spawned: %f', x.find_child("HealthComponent").MAX_HEALTH )
		await get_tree().create_timer(time).timeout

func _unhandled_input(_event):
	if Input.is_action_just_pressed("space"):
		spawn_next_wave()
