extends CanvasLayer


var time 
var timer
export var _listenerNodePath = ""


func _ready():
	if (_listenerNodePath != "" && _listenerNodePath != null):
		_listenerNodePath = get_node(_listenerNodePath)
	elif _listenerNodePath == "":
		_listenerNodePath = null
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)


func _on_timer_timeout():
	time += 1
	$InGameHUD/Time.text = String(time)

func _reset_timer():
	time = 0
	timer.start()
	$InGameHUD/Time.text = "0"

func _on_Resume_pressed():
	$InGameHUD.set_visible(true)
	$MiniMenu.set_visible(false)


func _on_Mini_Exit_pressed():
	$MiniMenu.set_visible(false)
	$MainMenu.set_visible(true)
	timer.stop()


func _on_Play_pressed():
	$MainMenu.set_visible(false)
	$InGameHUD.set_visible(true)
	_reset_timer()
	_listenerNodePath._load_scene(0)


func _on_Main_Exit_pressed():
	get_tree().quit()
	

var fromMain = true

func _on_Settings_pressed(isMain):
	$Settings.set_visible(true)
	fromMain = isMain
	$MainMenu.set_visible(false)
	$MiniMenu.set_visible(false)


func _on_Settings_Exit_pressed():
	$Settings.set_visible(false)
	$MainMenu.set_visible(fromMain)
	$MiniMenu.set_visible(!fromMain)
	
	
func _change_Loc_Name(name):
	$InGameHUD/LocationName.text = name
