class_name KnockBackComponent
extends Node
var knock_back_direction
@export var knock_back_power = 30
func knock_back(hitter,target):
	knock_back_direction = (hitter.global_position - target.global_position).normalized() * knock_back_power	
	target.global_position -= knock_back_direction
