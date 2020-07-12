extends Node2D

export(String) var break_name = "Cut Brakes"
export(String) var break_description = "Slower stopping"
export(bool) var broken = false
export(float) var modifier = 0.2

var _broken = false


func modify_velocity(velocity, forward):
	return velocity

func set_broken(broken):
	_broken = broken
	if _broken:
		get_parent().friction *= modifier
	else:
		get_parent().friction /= modifier
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func is_broken():
	return _broken
