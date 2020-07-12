extends Node2D

export(String) var break_name = "Shredded Treads"
export(String) var break_description = "Slower acceleration"
export(bool) var broken = false
export(float) var accel_modifier = 0.2
export(float) var friction_modifier = 0.4 # feels better with less friction

var _broken = false

func modify_velocity(velocity, forward):
	return velocity

func set_broken(broken):
	_broken = broken
	if _broken:
		get_parent().acceleration *= accel_modifier
		get_parent().friction *= friction_modifier
	else:
		get_parent().acceleration /= accel_modifier
		get_parent().friction /= friction_modifier
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")


func is_broken():
	return _broken
