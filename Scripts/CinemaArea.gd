extends Area2D


export var _listenerNodePath = ""


func _ready():
	if (_listenerNodePath != "" && _listenerNodePath != null):
		_listenerNodePath = get_node(_listenerNodePath)
	elif _listenerNodePath == "":
		_listenerNodePath = null


func _on_CinemaArea_body_entered(body):
	_listenerNodePath._set_cinema_visible(true)


func _on_CinemaArea_body_exited(body):
	_listenerNodePath._set_cinema_visible(false)
