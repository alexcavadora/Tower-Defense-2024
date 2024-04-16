extends Node2D
class_name PlayerAnimComponent
@export var Anim : AnimatedSprite2D
@export var Sword : AnimatedSprite2D
@onready var prevA
@onready var prevS

func changeanim(name):
	Anim.play(name)
	#print(name)
	
#func changesword(name):
	#if Sword.animation == "Attack":
		#print(Sword.animation)
		#print("Waiting...")
		#await Sword.animation_finished
		#Sword.stop()
		#print("Playing!")
		#Sword.play(name)
	#else:
		#print(Sword.animation)
		#Sword.stop()
		#print("Playing direct!")
		#Sword.play(name)
		#
	##print(name)
	

func _on_play_movement_component_change(animation):
	if animation != prevA:
		prevA = animation
		changeanim(animation)
	else:
		pass



func _on_player_attack_component_attack(animation):
	pass
	##print(animation)
	##if animation != prevS:
		##prevS = animation
	#print("Tryingtochange...")
	#changesword(animation)
	##else:
		##pass
