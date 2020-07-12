extends Node2D

export(String) var break_name = "Rotation Slowdown"
export(bool) var broken = false
export(float) var modifier = 0.2

var _broken = false

func init(player):
	set_broken(broken)

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
