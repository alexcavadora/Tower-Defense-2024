extends Node2D

var dialogue_scene = preload("res://addons/dialogue_quest/prefabs/ui/dialogue/components/dialogue_box/dialogue_box.tscn")
var dialogue_instance

var line = 1
var text = {
	1:
	{
		'name': 'Edmundo',
		'text': 'Lorem ipsum dolor sit amet'
	},
	2:
	{
		'name': 'Alex',
		'text': 'Sit amet lorem ipsum dolor.'
	},
	3:
	{
		'name': 'Isaac',
		'text': 'Dolor ipsum sit lorem amet.'
	},
	4:
	{
		'name': 'Chema',
		'text': 'Hola chicos.'
	},
	5:
	{
		'name': 'Dante',
		'text': 'Sit lorem ipsum amet dolor.'
	}
}
func _ready():
	dialogue_instance = dialogue_scene.instantiate()
	dialogue_instance.connect("proceed", on_proceed)
	
	dialogue_instance.set_name_text(text[line]['name'])
	dialogue_instance.set_text(text[line]['text'])
	get_parent().add_child.call_deferred(dialogue_instance)

func on_proceed():
	line += 1
	if line > text.size():
		dialogue_instance.queue_free()
		return
	dialogue_instance.set_name_text(text[line]['name'])
	dialogue_instance.set_text(text[line]['text'])
	dialogue_instance.start_progressing(0)

