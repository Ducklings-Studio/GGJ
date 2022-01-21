extends Control

func _on_Back_pressed():
	set_visible(false)
	$"../MiniMenu".set_visible(true)
