extends KinematicBody2D

export (int) var speed = 180
export (int) var jump_speed = -1000
export (int) var gravity = 35

var velocity = Vector2.ZERO

func _physics_process(_delta):
	velocity.y += gravity
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$ASprite.play("walk")
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$ASprite.play("walk")
	
	if velocity.x < 0 or (velocity.x == 0 and speed < 0):
		$ASprite.flip_h = true
	else:
		$ASprite.flip_h = false
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		$ASprite.play("jump")
	
	if is_on_floor() and abs(velocity.x) < 0.1:
		$ASprite.play("idle")
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)
	
func _unhandled_key_input(event):
	if event.is_pressed():
		if event.is_action_pressed("ui_cancel"):
			$"../../HUD/MiniMenu".set_visible(!$"../../HUD/MiniMenu".visible)
			get_tree().set_input_as_handled()

func _on_VisibilityNotifier2D_screen_exited():
	#queue_free()
	pass
