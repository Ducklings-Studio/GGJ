extends Node2D


export var _listenerNodePath = ""
var scenes = [preload("res://Scenes/Level_Test.tscn"), 
				preload("res://Scenes/Level_1.tscn"),
				preload("res://Scenes/Level_2.tscn"),
				preload("res://Scenes/Level_3.tscn")]
const names = ["Test", "Swamp", "Mountains", "Castle"]
var music = ["res://Assets/Audio/PamPam.wav",
			"res://Assets/Audio/SwampBg.ogg", 
			"res://Assets/Audio/MountainBg.ogg", 
			"res://Assets/Audio/CastleBg.ogg"]
var cameraSettings = [298, 302, 302, 300.576]
var current_lvl
var temp


func _ready():
	Global.deathNum = 0
	if (_listenerNodePath != "" && _listenerNodePath != null):
		_listenerNodePath = get_node(_listenerNodePath)
	elif _listenerNodePath == "":
		_listenerNodePath = null

func _on_winning():
	if current_lvl < 4:
		next_scene()
	else:
		_listenerNodePath.congrats()


func _on_death():
	Global.deathNum += 1
	AudioManager.play("res://Assets/Audio/Lose.wav")
	_listenerNodePath._reset_timer()
	_load_scene(max(1, current_lvl - 2))


func _restart():
	_load_scene(max(1, current_lvl - 1))


func _load_scene(id):
	if temp != null and is_instance_valid(temp):
		temp.queue_free()
	current_lvl = id
	next_scene()


func next_scene():
	Global.cameraSettings = cameraSettings[current_lvl]
	AudioManager.set_music(music[current_lvl])
	temp = scenes[current_lvl].instance()
	call_deferred("add_child", temp)
	_listenerNodePath._change_Loc_Name(names[current_lvl])
	current_lvl += 1
