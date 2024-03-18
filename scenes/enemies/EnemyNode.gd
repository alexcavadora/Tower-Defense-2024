class_name EnemyNode
extends CharacterBody2D

var current_path: Array[Vector2i]
@onready var tilemap = $"../Ground"
@onready var movement_component = $MovementComponent
@onready var sprite_component = $SpriteComponent
var startIndex = 0

func _ready():
	movement_component.init(tilemap.starting_tile[startIndex], tilemap.finishing_tile, tilemap)
	sprite_component.start_animation()
	movement_component.connect("path_completed", _on_path_completed)

func _delta():
	move_and_slide()

func _on_path_completed():
	sprite_component.play("death")
	sprite_component.connect("animation_finished", _on_animation_finished)  # Connect

func _on_animation_finished():
	queue_free()
