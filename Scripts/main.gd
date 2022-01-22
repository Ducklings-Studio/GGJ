extends Node2D

var current_lvl
var scenes = [preload("res://Scenes/Level_Test.tscn"), 
				preload("res://Scenes/Level_1.tscn"),
				preload("res://Scenes/Level_2.tscn")]
const names = ["Test", "Swamp", "City", "Castle"]
var temp
export var _listenerNodePath = ""


func _ready():
	if (_listenerNodePath != "" && _listenerNodePath != null):
		_listenerNodePath = get_node(_listenerNodePath)
	elif _listenerNodePath == "":
		_listenerNodePath = null

func _on_winning():
	if current_lvl < 4:
		print(current_lvl)
		next_scene()
	else:
		#TODO winning scene
		print("You won")


func _on_death():
	print("You dead")
	_listenerNodePath._reset_timer()
	_load_scene(max(0, current_lvl - 1))


func _restart():
	_load_scene(max(0, current_lvl - 1))


func _load_scene(id):
	if temp != null:
		temp.queue_free()
	current_lvl = id
	next_scene()


func next_scene():
	temp = scenes[current_lvl].instance()
	call_deferred("add_child", temp)
	_listenerNodePath._change_Loc_Name(names[current_lvl])
	current_lvl += 1
	current_lvl %= 3
