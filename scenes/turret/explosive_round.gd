extends RigidBody2D
var damage
var enemies_in_range = []
var lifespan = 0
func _ready():
	for i in $Area2D.get_overlapping_bodies():
		enemies_in_range.append(i)
	
func _physics_process(delta):
	if lifespan > 5:
		queue_free()
	var collision = move_and_collide(linear_velocity.normalized()*delta)
	if collision != null:
		if collision.get_collider().is_in_group("enemy"):
			explode()
			#print("Collided with: ",collision.get_collider().name )
			$Sprite2D.play('hit')
			linear_velocity = Vector2.ZERO
			disable_mode = CollisionObject2D.DISABLE_MODE_MAKE_STATIC
		else:
			$Sprite2D.play('hit')
	lifespan += delta

func explode():
	for i in enemies_in_range:
		i.find_child("HealthComponent").damage(damage)
	
func _on_sprite_2d_animation_finished():
	queue_free();

func _on_area_2d_body_entered(body):
	if body.is_in_group('enemy'):
		enemies_in_range.append(body)

func _on_area_2d_body_exited(body):
	if body.is_in_group('enemy'):
		enemies_in_range.erase(body) 

func _on_timer_timeout():
	explode()
