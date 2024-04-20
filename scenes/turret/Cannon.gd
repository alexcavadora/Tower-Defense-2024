extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false
var enemies = []
var target
var lvl = 0

@export var shooting_frame = 3
@export var n = ''
@export var cost ={
	'build': 	 50,
	'upgrade 1': 150,
	'upgrade 2': 300
}
@export var rotation_speed = 0.05
@export var bullet_scn : PackedScene
@export var bullet_speed = 600.0 
@export var bps = 1.0
@export var bullet_dmg = 30
@onready var fire_rate = 1.0/bps

var cooldown = 0
func _process(_delta):
	if Input.is_action_just_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		$"../Camera2D/UI".credits += cost['build']
		queue_free()
	if ghost:
		return
	for i in enemies:
		if i.find_child('SpriteComponent').animation == 'death':
			enemies.erase(i) 
	if enemies != [] and target != null:
		if !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play('%d' % lvl, 2 + 2*lvl)
		rotation = lerp_angle(rotation, position.angle_to_point(target.global_position), rotation_speed)
	else:
		$AnimatedSprite2D.play("idle")
		$AnimatedSprite2D.frame = lvl
		$AnimatedSprite2D.pause()
		rotation = lerp_angle(rotation,  -PI/2, rotation_speed)

func _on_area_2d_body_entered(body):
	if body.is_in_group('enemy'):
		enemies.append(body)
		target = enemies[0]

func _on_area_2d_body_exited(body):
	if body.is_in_group('enemy') and enemies!= []:
		target = enemies[0]
		enemies.erase(body)

func shoot():
	var bullet = bullet_scn.instantiate()
	bullet.rotation = rotation
	#print($Muzzle.global_position)
	bullet.get_child(0).play()
	bullet.global_position = $Muzzle.global_position
	bullet.linear_velocity = (target.global_position - bullet.global_position ).normalized() * bullet_speed
	bullet.damage = bullet_dmg
	get_parent().add_child.call_deferred(bullet)

func _on_upgraded_animation_finished():
	$Upgraded.hide()
	$Upgraded.pause()

func _ready():
	$AnimatedSprite2D.stop()
	$Control.connect("pressed", _on_control_pressed)
	$"../Camera2D/UI".connect('turret_selected', on_turret_selected)
	$AnimatedSprite2D.connect('frame_changed', _on_animated_sprite_2d_frame_changed)

func on_turret_selected(turret):
	if turret == n:
		$Control.disabled = false
	else:
		$Control.disabled = true

func _on_control_pressed():
	if lvl < 2:
		lvl += 1
		$AnimatedSprite2D.frame = lvl
		$Upgraded.show()
		$Upgraded.frame = 0
		$Upgraded.play()
	else:
		$Control.disabled = true


#func _on_animated_sprite_2d_animation_finished():
	#shoot()


func _on_animated_sprite_2d_frame_changed():
	if $AnimatedSprite2D.get_frame() == shooting_frame:
		shoot()
