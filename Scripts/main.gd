extends Node2D

var current_lvl
var scenes = [preload("res://Scenes/Level_Test.tscn"), 
				preload("res://Scenes/Level_1.tscn"),
				preload("res://Scenes/Level_2.tscn")]
var temp

func _on_winning():
	if current_lvl < 4:
		next_scene()
	else:
		print("You won")


func _load_scene(id):
	if temp != null:
		temp.queue_free()
	current_lvl = id
	next_scene()


func next_scene():
	temp = scenes[current_lvl].instance()
	add_child(temp)
	current_lvl += 1
	current_lvl %= 3
