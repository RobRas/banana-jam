extends Node

signal shot_input(input_value)
var _equipped = true

func _on_Timer_timeout():
	if not _equipped:
		return
	
	emit_signal("shot_input", 1)
	#$ShotgunSound.play()

func equip():
	_equipped = true

func unequip():
	_equipped = false
