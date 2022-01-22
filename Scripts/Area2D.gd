extends Area2D

var amount = 0
export var _listenerNodePath = ""

func _ready():
	if (_listenerNodePath != "" && _listenerNodePath != null):
		_listenerNodePath = get_node(_listenerNodePath)
	elif _listenerNodePath == "":
		_listenerNodePath = null
	

func _physics_process(_delta):
	if get_node_or_null("../Player_copy") == null or get_node_or_null("../Player") == null:
		_listenerNodePath._on_death()
		$"..".queue_free()
	elif amount == 2 and $"../Player".is_on_floor() and $"../Player_copy".is_on_floor():
		_listenerNodePath._on_winning()
		$"..".queue_free()


func _on_Area2D_body_entered(_body):
	amount += 1


func _on_Area2D_body_exited(_body):
	amount -= 1
