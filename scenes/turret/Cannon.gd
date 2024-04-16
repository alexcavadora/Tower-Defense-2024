extends StaticBody2D
var coords: Vector2i  = Vector2i(0,0)
var ghost = false
var enemies = []
var target
@export var rotation_speed = 0.05

@export var bullet_scn : PackedScene
@export var bullet_speed = 600.0 
@export var bps = 1.0
@export var bullet_dmg = 30
@onready var fire_rate = 1.0/bps
var cooldown = 0

func _process(delta):
	if ghost:
		return
	for i in enemies:
		if i.find_child('SpriteComponent').animation == 'death':
			enemies.erase(i) 
	if enemies != [] and target != null:
		shoot(delta)
		rotation = lerp_angle(rotation, position.angle_to_point(target.global_position) + PI/2, rotation_speed)
	else:
		rotation = lerp_angle(rotation, PI, rotation_speed)

func _unhandled_input(_event):
	if Input.is_action_pressed("right_click") and !ghost and $"../Ground".local_to_map(get_global_mouse_position()) == coords:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group('enemy'):
		enemies.append(body)
		target = enemies[0]


func _on_area_2d_body_exited(body):
	if body.is_in_group('enemy') and enemies!= []:
		target = enemies[0]
		enemies.erase(body)

func shoot(delta):
	if (cooldown > fire_rate):
		var bullet = bullet_scn.instantiate()
		bullet.rotation = rotation
		#print($Muzzle.global_position)
		bullet.get_child(0).play()
		bullet.global_position = $Muzzle.global_position
		bullet.linear_velocity = (target.global_position - bullet.global_position ).normalized() * bullet_speed
		bullet.damage = bullet_dmg
		get_parent().add_child.call_deferred(bullet)
		cooldown = 0
	else:
		cooldown += delta
	
