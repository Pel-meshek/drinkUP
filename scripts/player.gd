extends CharacterBody2D


const SPEED = 200.0


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("left", "right")
	if direction_x:
		velocity.x = direction_x * SPEED
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.flip_h = false
	var direction_y := Input.get_axis("up","down")
	if direction_y >= 0:
		velocity.y = direction_y * SPEED
		$AnimatedSprite2D.flip_v = true
	elif direction_y < 0:
		velocity.y = direction_y * SPEED
		$AnimatedSprite2D.flip_v = false
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	if direction_x or direction_y:
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()
