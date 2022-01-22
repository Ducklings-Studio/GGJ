extends CanvasLayer


var time 

func _ready():
	time = 0
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.start()


func _on_timer_timeout():
	time += 1
	$InGameHUD/Time.text = String(time)


#mb unite with _on_Play_pressed
func _on_Resume_pressed():
	$InGameHUD.set_visible(true)
	$MiniMenu.set_visible(false)


func _on_Mini_Exit_pressed():
	$MiniMenu.set_visible(false)
	$MainMenu.set_visible(true)


func _on_Main_Exit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	$MainMenu.set_visible(false)
	$InGameHUD.set_visible(true)
	#TODO add lvl loading

var fromMain

func _on_Settings_pressed(isMain):
	$Settings.set_visible(true)
	fromMain = isMain
	$MainMenu.set_visible(false)
	$MiniMenu.set_visible(false)


func _on_Settings_Exit_pressed():
	$Settings.set_visible(false)
	$MainMenu.set_visible(fromMain)
	$MiniMenu.set_visible(!fromMain)
