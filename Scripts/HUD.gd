extends CanvasLayer


var time 
var timer
export var _listenerNodePath = ""
var num = 0.2
onready var animationHeart = $"MainMenu/AnimationHearts"


func _ready():
	if (_listenerNodePath != "" && _listenerNodePath != null):
		_listenerNodePath = get_node(_listenerNodePath)
	elif _listenerNodePath == "":
		_listenerNodePath = null
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	animationHeart.play("updown")

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
	_listenerNodePath._load_scene(1)


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


func _on_Music_value_changed(value):
	AudioManager.music_vol = -3*value
	AudioManager.set_volume()


func _on_Audio_value_changed(value):
	AudioManager.audio_vol = -3*value
	AudioManager.set_volume()


func _on_LocCheckBox_toggled(button_pressed):
	$InGameHUD/LocationName.set_visible(button_pressed)


func _on_TimeCheckBox_toggled(button_pressed):
	$InGameHUD/Time.set_visible(button_pressed)
