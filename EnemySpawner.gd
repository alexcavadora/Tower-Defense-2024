class_name spawnerNode
extends Node

var slime_scene = preload("res://scenes/enemies/slime.tscn")
var zombie_scene = preload("res://scenes/enemies/zombie.tscn")
var orc_scene = preload("res://scenes/enemies/orc.tscn")
var enemies = [slime_scene, zombie_scene, orc_scene]
@export var waves: Array[String] = [""]
# Called when the node enters the scene tree for the first time.
func spawn():
	for i in enemies:
		var x = i.instantiate()
		x.startIndex = randi_range(0,$"../Ground".starting_tile.size()-1)
		get_parent().add_child.call_deferred(x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _unhandled_input(_event):
	if Input.is_action_just_pressed("space"):
		spawn()
