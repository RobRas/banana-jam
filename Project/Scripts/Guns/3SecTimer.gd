extends Node

signal shot_input(input_value)
var _enabled = true

func _on_Timer_timeout():
	if not _enabled:
		return
	
	emit_signal("shot_input", 1)
	#$ShotgunSound.play()

func enable():
	_enabled = true

func disable():
	_enabled = false
