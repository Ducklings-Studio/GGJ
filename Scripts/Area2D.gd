extends Area2D

var amount = 0

func _process(_delta):
	if amount == 2 and $"../Player".is_on_floor() and $"../Player_copy".is_on_floor():
		Main._on_winning()


func _on_Area2D_body_entered(_body):
	amount += 1


func _on_Area2D_body_exited(_body):
	amount -= 1
