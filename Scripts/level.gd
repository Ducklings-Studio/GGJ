extends Node2D

var y_s = 302

var boom_effect = preload("res://Scenes/Boom.tscn")
var tilemap

func _ready():
	tilemap = $TileMap
	if get_node_or_null("tutorial") != null:
		$tutorial.set_visible(Global.showTutorial)
	y_s = Global.cameraSettings

func _input(event):
	if event is InputEventMouseButton:
		if get_node_or_null("tutorial") != null:
			$tutorial.set_visible(Global.showTutorial)
		var pos = event.position
		if event.pressed:
			var tile_pos = tilemap.world_to_map(pos)
			var delta = $Player/Camera2D.get_camera_screen_center().y - y_s
			tile_pos.y += round(delta/32)
			var cell = tilemap.get_cellv(tile_pos)
			var cell_sp = tilemap.get_cell_autotile_coord(tile_pos.x, tile_pos.y)
			var cell2 = tilemap.get_cell(31 - tile_pos.x, tile_pos.y)
			if cell != -1 and cell2 == -1:
				var effect = boom_effect.instance()
				add_child(effect)
				effect.global_position = (2*tile_pos + Vector2.ONE)*16
				var effect2 = boom_effect.instance()
				add_child(effect2)
				effect2.global_position = Vector2(63 - 2*tile_pos.x, 2*tile_pos.y+1)*16
				
				var fl = tilemap.is_cell_x_flipped(tile_pos.x, tile_pos.y)
				tilemap.set_cell(31 - tile_pos.x, tile_pos.y, cell, 
				!fl, false, false, cell_sp)
				tilemap.set_cell(tile_pos.x, tile_pos.y, -1)
				AudioManager.play("res://Assets/Audio/Translation.wav")
				if is_dead(pos):
					$Player_copy.queue_free()

func is_dead(pos):
	var pg_1 = $Player.get_global_transform_with_canvas().origin
	var pg_2 = $Player_copy.get_global_transform_with_canvas().origin
	var p_1 = tilemap.world_to_map(pg_1)
	var p_2 = tilemap.world_to_map(pg_2)
	var l_1 = tilemap.world_to_map(pos)
	var l_2 = Vector2(31-l_1.x,l_1.y)
	return l_1==p_1 or l_2 == p_1 or l_1 == p_2 or l_2 == p_2
