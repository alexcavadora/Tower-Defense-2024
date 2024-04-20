extends TileMap

signal updated
var astar = AStarGrid2D.new()
var map_rect = Rect2i()
var cannon_turret = preload("res://scenes/turret/Cannon.tscn")
var missile_turret = preload("res://scenes/turret/Missile_launcher.tscn")
var mg_turret = preload("res://scenes/turret/MG.tscn")
var barricade = preload("res://scenes/turret/barricade.tscn")
var medic = preload("res://scenes/turret/medic.tscn")
var generator = preload("res://scenes/turret/generator.tscn")
var net = preload("res://scenes/turret/bolas.tscn")

var x = cannon_turret
var y = cannon_turret.instantiate()
@export var finishing_tile = Vector2i(0,0)
@export var starting_tile : Array[Vector2i] = [Vector2i()]
@export var player : CharacterBody2D
var tile_size
var tilemap_size
var arrow_layer : int = 2
var road_layer: int = 1
var terrain_layer : int = 3
var sel_turret: String = "cannon"
var pos
var prev = Vector2i(0,0)
var locked_path = [Vector2i(0,0),Vector2i(0,0)]
var placed_barricades = []
var placed_turrets = []



func _ready():
	tile_size = get_tileset().tile_size
	tilemap_size = get_used_rect().end - get_used_rect().position
	map_rect = Rect2i(Vector2i(0,0), tilemap_size)
	
	#setting up the astar logic
	astar.region = map_rect
	astar.cell_size = tile_size
	astar.offset = tile_size * 0.5
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	update()

func _process(_delta):
	pos = local_to_map(get_global_mouse_position())
	if Input.is_action_just_pressed("click"):
		x = null
		if y != null:
			y.queue_free()
		if pos not in placed_barricades and sel_turret != "barricade":
			return
		if astar.is_point_solid(pos) and sel_turret == "barricade":
			return
		if pos in placed_turrets:
			return
			
		if sel_turret == "cannon":
			x = cannon_turret.instantiate()
		elif sel_turret == "missile_launcher":
			x = missile_turret.instantiate()
		elif sel_turret == "MG":
			x = mg_turret.instantiate()
		elif sel_turret == "barricade":
			x = barricade.instantiate()
		elif sel_turret == 'medic':
			x = medic.instantiate()
		elif sel_turret == 'generator':
			x = generator.instantiate()
		elif sel_turret == 'net':
			x = net.instantiate()
		elif sel_turret == "empty":
			return
		if $"../Camera2D/UI".credits >= x.cost['build']:
			$"../Camera2D/UI".credits -= x.cost['build']
		else:
			return
		x.global_position = map_to_local(pos)
		x.coords = pos
		get_parent().add_child.call_deferred(x)
		astar.set_point_solid(pos, true)

		if sel_turret == 'barricade':
			placed_barricades.append(pos)
		else:
			placed_turrets.append(pos)
		update()
		for i in starting_tile:
			if astar.get_id_path(i, finishing_tile).is_empty() or pos == i:
				set_cell(terrain_layer, pos, -1,Vector2i(-1,-1))
				astar.set_point_solid(pos, false)
				x.queue_free()
				if sel_turret == 'barricade':
					placed_barricades.erase(pos)
				else:
					placed_turrets.append(pos)
				update()
				break
		return
		# for some reason does not allow to change the original path in any way
		# for i in starting_tile:
		#	if create_optimal_path(i,finishing_tile) == false:
		#			set_cell(terrain_layer, pos, -1, Vector2i(-1,-1))
		#			astar.set_point_solid(pos, false)
	elif Input.is_action_just_pressed("right_click") and pos in placed_barricades:#astar.is_point_solid(pos) == true:
		for i in starting_tile:
			if i == pos or i == finishing_tile:
				return
		astar.set_point_solid(pos, false)
		placed_barricades.erase(pos)
		placed_turrets.erase(pos)
		update()
		return
	#getting the coordenates of the mouse in local coords

	#if the mouse is still slecting the same tile, or is outside of the game area
	#for example, windowed mode, it will avoid any unnecesary calculations
	if prev == pos || astar.is_in_bounds(pos.x,pos.y) == false:
		return
	
	#now that the position has changed,
	#if not deleted yet, delete the previous ghost turret
	if y != null: 
		y.queue_free()
		update(2) #updating just the arrow road, not changing the current road enemies know about
	
	# when not selecting a tower, you have no need to be shown future changes in the road
	# this was added here to update when changing to nothing while not moving the mouse
	if sel_turret == "empty":
		GlobalVariables.VisibleSword = true 
		update(2) 
		prev = pos #do nothing until something changes
		return
	
	#if the mouse is now on top of a tower or obstacle
	if pos not in placed_barricades and sel_turret != "barricade" :
		update(2) 
		prev = pos
		return
	
	if pos in placed_barricades and pos in placed_turrets:
		update(2) 
		return
		
	if astar.is_point_solid(pos) and sel_turret == "barricade":
		update(2) 
		prev = pos
		return
	
	# selecting and instancing the ghost of tower objectwith required characteristics 
	# at mouse position based on UI element selected by click or keyboard
	if sel_turret == "cannon":
		GlobalVariables.VisibleSword = false
		y = cannon_turret.instantiate()
		
	elif sel_turret == "missile_launcher":
		GlobalVariables.VisibleSword = false
		y = missile_turret.instantiate()
		
	elif sel_turret == "MG":
		GlobalVariables.VisibleSword = false
		y = mg_turret.instantiate()
		
	elif sel_turret == "barricade":
		GlobalVariables.VisibleSword = false
		y = barricade.instantiate()
		
	elif sel_turret == "medic":
		y = medic.instantiate()
		
	elif sel_turret == 'generator':
		y = generator.instantiate()
	
	elif sel_turret == 'net':
		y = net.instantiate()
		
	y.global_position = map_to_local(pos)
	y.coords = pos
	y.get_child(0).modulate.a8 = 125
	y.ghost = true
	y.find_child('CollisionShape2D').disabled = true
	
	get_parent().add_child.call_deferred(y)
	
	if sel_turret != "barricade":
		return
	# letting the map know this coord is now solid, but just to show the player what would happen
	# before notifying enemies
	astar.set_point_solid(pos, true)
	update(2)
	
	# check for every starting tile if the road has not been found
	for i in starting_tile:
		if pos == i or pos == finishing_tile:
			y.get_child(0).modulate = Color(0.5, 0.5, 0.5, 1)
			update(2)
		if astar.get_id_path(i, finishing_tile).is_empty():
			y.get_child(0).modulate = Color(0.5, 0.5, 0.5, 1)
			update(1) #updating just the arrow road, not changing the current road enemies know about, and also letting the pahtfinder know it failed
	
	astar.set_point_solid(pos, false)
	
	prev = pos 

func update(type : int = 0):
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coordinates = Vector2i(i, j)
			var tile_data = get_cell_tile_data(terrain_layer, coordinates)
			if tile_data and tile_data.get_custom_data('solid'):
				astar.set_point_solid(coordinates)
	if type == 0:
		emit_signal("updated")
	var args = []
	for i in starting_tile:
		args.push_front(create_optimal_path(i, finishing_tile, type))
	paint_optimal_paths(args, type)
	locked_path = args

func is_point_walkable(map_position):
	if map_rect.has_point(map_position):
		return not astar.is_point_solid(map_position)
	return false

func create_optimal_path(start, finish: Vector2i, type):
	var path = astar.get_id_path(start, finish)
	if type == 1: 
		astar.set_point_solid(pos, false)
		path = astar.get_id_path(start, pos)
		astar.set_point_solid(pos, true)
	return path

func paint_optimal_paths (paths, type: int = 0):
	clear_layer(arrow_layer)
	if type == 0:
		clear_layer(road_layer)
	for path in paths:
		if type == 1 and path.back() == pos:
			path.pop_back()
		if !locked_path.has(path) and path or type == 1 and path:
			set_cells_terrain_path(arrow_layer, path, 2, 0) 
			
			# checking adjacent tiles of the starting position to override a weird bug in autotiling
			var origin_direction = find_origin_direction(path.front())
			if origin_direction == 'left':
				set_cell(2, path.front(), 1, Vector2i(3,2))
			elif origin_direction == 'right':
				set_cell(2, path.front(), 1, Vector2i(3,1))
			elif origin_direction == 'up':
				set_cell(2, path.front(), 1, Vector2i(4,1))
			else:
				set_cell(2, path.front(), 1, Vector2i(4,0))
		if type == 0:
			set_cells_terrain_path(road_layer, path, 1, 0) # drawing the road on the ground
		

func find_origin_direction(cell):
	if cell:
		if(get_cell_source_id(arrow_layer, Vector2i(cell.x+1,cell.y)) == 1):
			return 'right'
		if(get_cell_source_id(arrow_layer, Vector2i(cell.x-1,cell.y)) == 1):
			return 'left'
		if (get_cell_source_id(arrow_layer, Vector2i(cell.x,cell.y-1)) == 1):
			return 'up'
	return 'down'

func _on_control_turret_selected(turr):
	sel_turret = turr
	
	prev = Vector2i(-1, -1)

func _on_spawner_node_wave_changed(_x):
	#set_layer_enabled(arrow_layer, false)
	pass

func _on_spawner_node_wave_ended():
	#set_layer_enabled(arrow_layer, true)
	pass
