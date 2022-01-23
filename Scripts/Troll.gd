extends Area2D

func _on_Troll_body_entered(body):
	AudioManager.play("res://Assets/Audio/Glad.wav")
	queue_free()
