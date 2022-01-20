extends KinematicBody2D

export (int) var speed = 180
export (int) var jump_speed = -1000
export (int) var gravity = 35

var velocity = Vector2.ZERO

#magic number
const y_s = 306

func _input(event):
	if event is InputEventMouseButton:
		var pos = event.position
		if event.pressed:
			var tilemap = $"../TileMap"
			var tile_pos = tilemap.world_to_map(pos)
			var delta = $"../Player/Camera2D".get_camera_screen_center().y - y_s
			tile_pos.y += round(delta/32)
			var cell = tilemap.get_cellv(tile_pos)
			var cell_sp = tilemap.get_cell_autotile_coord(tile_pos.x, tile_pos.y)
			var cell2 = tilemap.get_cell(31 - tile_pos.x, tile_pos.y)
			if cell != -1 and cell2 == -1:
				var fl = tilemap.is_cell_x_flipped(tile_pos.x, tile_pos.y)
				tilemap.set_cell(31 - tile_pos.x, tile_pos.y, cell, 
				!fl, false, false, cell_sp)
				tilemap.set_cell(tile_pos.x, tile_pos.y, -1)

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
