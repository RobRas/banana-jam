extends Node

signal shot_input(input_value)

func _on_Timer_timeout():
	emit_signal("shot_input", 1)
	#$ShotgunSound.play()
