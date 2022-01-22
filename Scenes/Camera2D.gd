extends Camera2D

var prev

func _ready():
	prev = transform


func _process(delta):
	if global_transform != prev:
		prev = global_transform
		#print(global_transform)


func _on_VisibilityNotifier2D_screen_exited():
	print('kar')


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	pass # Replace with function body.
