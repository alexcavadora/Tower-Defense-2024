class_name MovementComponent
extends Node2D
signal path_completed
signal direction_changed(String)
var current_path: Array[Vector2i]
@export var creature_speed = 0.75
var tm : TileMap
var starting_tile : Vector2i = Vector2i(0,0)
var finishing_tile : Vector2i = Vector2i(0,0)
var current_direction = "South"
var new_direction = current_direction


func init(st, ft, tile):
	get_parent().global_position = tile.map_to_local(st)
	self.starting_tile = st
	self.finishing_tile = ft
	self.tm = tile
	self.current_path = tile.astar.get_id_path(st, ft).slice(1)
	if tm:
		tm.connect("updated",update_path)

func _physics_process(_delta):
	if current_path.is_empty():
		emit_signal("path_completed")
		queue_free()
		return
	if $"../SpriteComponent".animation == 'death':
		return
	var target_position = tm.map_to_local(current_path.front())
	var delta = get_parent().global_position
	get_parent().global_position = global_position.move_toward(target_position, creature_speed)
	delta = delta - get_parent().global_position
	if delta.y<=0:
		new_direction = "South"
	elif delta.y >0:
		new_direction = "North"
	if current_direction != new_direction:
		emit_signal('direction_changed', new_direction)
		current_direction = new_direction
	if global_position == target_position:
		current_path.pop_front()

func update_path():
	current_path = tm.astar.get_id_path(tm.local_to_map(global_position), finishing_tile).slice(1)
