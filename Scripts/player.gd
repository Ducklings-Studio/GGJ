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
		$ASprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$ASprite.play("walk")
		$ASprite.flip_h = true
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
		$ASprite.play("jump")
	
	if is_on_floor() and abs(velocity.x) < 0.1:
		$ASprite.play("idle")
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)
