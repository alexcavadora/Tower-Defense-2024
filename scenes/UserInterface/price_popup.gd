extends VBoxContainer

var price_display
var upgrade = false 
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text ="Build:\n {build}G\nUpgrade 2:\n{upgrade 1}G\nUpgrade 3:\n{upgrade 2}G".format(price_display) 
	
