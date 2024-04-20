extends RigidBody2D
var damage
var lifespan = 0
	
func _physics_process(delta):
	if lifespan > 5:
		queue_free()
	var collision = move_and_collide(linear_velocity.normalized()*delta)
	if collision!=null:
		if collision.get_collider().is_in_group("enemy"):
			#print("Collided with: ",collision.get_collider().name )
			collision.get_collider().find_child("HealthComponent").damage(damage)
			$Sprite2D.play('hit')
			$CollisionShape2D.disabled = true
			linear_velocity = Vector2.ZERO
			position = collision.get_collider().position 
			#freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
			#set_freeze_enabled(true)
		else:
			$Sprite2D.play('hit')
			freeze_mode = RigidBody2D.FREEZE_MODE_STATIC
			set_freeze_enabled(true)
		lifespan += delta

func _on_sprite_2d_animation_finished():
	queue_free();


func _on_timer_timeout():
	linear_velocity = Vector2.ZERO
	$Sprite2D.play('hit')
