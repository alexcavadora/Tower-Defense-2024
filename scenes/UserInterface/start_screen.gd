class_name StartScreen extends Control

# Note, in a larger project I'd probably have an Autoload with all the level paths saved
# in a Dictionary so that if the paths change you only have to change them in one place
# When attempting to load a Scene, you can set up a helper function that checks the string
# against keys in your dictionary, if a key is found, return the path, otherwise just load
# the path given - which allows you to load from keys or full paths... but for this exmample I kept it simpler

# These 4 lines are not covered in the initial video. They've been added here just to make it easier for you
# to differentiate versions. I had not intended to provide updates so this feature was skipped in original code.
	# deferral/no unload examples
@onready var version_num: Label = %VersionNum

func _ready() -> void:
	pass
	#version_num.text = "v%s" % SceneManager.VERSION
	#print("Project version: %s" % SceneManager.VERSION)
#	SceneManager.swap_scenes("res://Gameplay/player.tscn",get_tree().root,null,"no_transition")
#	SceneManager.call_deferred("swap_scenes","res://Gameplay/player.tscn",get_tree().root,null,"no_transition")

#func _on_button_button_up() -> void:
	
	# call from v1.0 - won't work in this version
#	SceneManager.load_new_scene("res://Gameplay/Levels/level1.tscn","wipe_to_right")
	
	
	# no unload example
#	SceneManager.swap_scenes("res://Gameplay/player.tscn",get_tree().root,null,"no_transition")
	
func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.swap_scenes("res://scenes/maps/Testing_map.tscn",get_tree().root,self,"wipe_to_right")
		


func _on_texture_button_pressed() -> void:
	SceneManager.swap_scenes("res://scenes/maps/Testing_map.tscn",get_tree().root,self,"wipe_to_right")
