extends Node2D

var current_lvl
const prefix = "res://Scenes/"
var pathes = ["Level_Test.tscn", "Level_1.tscn", "Level_2.tscn"]
var temp

func _ready():
	current_lvl = 1
	next_scene()
	

func _on_winning():
	print("You won")
	next_scene()
	

func next_scene():
	temp = load(prefix + pathes[current_lvl])
	add_child(temp.instance())
	current_lvl += 1
	current_lvl %= 3
