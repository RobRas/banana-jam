extends Node2D

export(String) var break_name = "Rusted Axles"
export(String) var break_description = "Inconsistent turn rate"
export(bool) var broken
export(float) var speed_modifier = 0.5

var _broken = false


func set_broken(broken):
	_broken = broken
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func modify_rotation_angle(delta, angle):
	if not _broken:
		return angle
	
	return angle * speed_modifier

func is_broken():
	return _broken
