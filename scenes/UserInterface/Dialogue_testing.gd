extends Control

var dialogue_scene = preload("res://addons/dialogue_quest/prefabs/ui/dialogue/components/dialogue_box/dialogue_box.tscn")
var dialogue_instance


@export var next : PackedScene

var line = 1
@export var text = {
	1:
	{
		'name': 'Jorge (Diario)',
		'text': 'Somos conquistadores. '
	},
	2:
	{
		'name': 'Jorge (Diario)',
		'text': 'Acabamos de tomar el control de una aldea rural que parece ser de alta importancia para los locales.'
	},
	3:
	{
		'name': 'Jorge (Diario)',
		'text': 'Aunque bueno, “tomar control” puede que no sea la manera más apropiada de describirlo, dado a que todos huyeron al vernos, y habíamos recibido oposición fuerte de los aldeanos hasta ahora.  '
	},
	4:
	{
		'name': 'Jorge (Diario)',
		'text': 'Montamos campamento para la noche y todos mis camaradas sienten que hay algo raro con el lugar. '
	},

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
		get_tree().change_scene_to_packed(next)
		return
	dialogue_instance.set_name_text(text[line]['name'])
	dialogue_instance.set_text(text[line]['text'])
	dialogue_instance.start_progressing(0)

