extends Node2D

var scene = PackedScene.new()
var ground
var tiles = load("res://Tutorial_Tiles.tscn")

	
func _ready():
	var map = tiles
	add_child(map)
