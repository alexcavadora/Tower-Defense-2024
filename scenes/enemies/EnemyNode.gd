class_name EnemyNode
extends CharacterBody2D

var current_path: Array[Vector2i]
@onready var tilemap = $"../Ground"
@onready var movement_component = $MovementComponent
@onready var sprite_component = $SpriteComponent
@onready var UI = $"../Camera2D/Control/"

var startIndex = 0
signal died(hp: int)
signal reached_goal(dmg : int)

func _ready():
	movement_component.init(tilemap.starting_tile[startIndex], tilemap.finishing_tile, tilemap)
	sprite_component.start_animation()
	movement_component.connect("path_completed", _on_path_completed)
	sprite_component.connect("animation_finished",  _on_animation_finished)
	connect('reached_goal', UI._on_enemy_reached_goal)
	connect('died', UI._on_enemy_died)

func _delta():
	move_and_slide()

func _on_path_completed():
	sprite_component.play("death")
	emit_signal("died",2)
	emit_signal("reached_goal", 2)
	
func _on_animation_finished():
	queue_free()

	
