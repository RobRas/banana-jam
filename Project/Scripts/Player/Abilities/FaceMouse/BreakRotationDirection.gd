extends Node2D

export(String) var break_name = "Rotation Slowdown"
export(bool) var broken
export(float) var modifier = 0.1

var _broken = false
var _direction = -1


func _ready():
	set_broken(broken)

func set_broken(broken):
	_broken = broken
	if _broken:
		_direction = -1 if (randi() % 2) == 0 else 1
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func modify_rotation_angle(delta, angle):
	if not _broken:
		return angle
	
	var new_angle = angle
	
	if sign(angle) == _direction:
		return angle * modifier
	
	return angle

func is_broken():
	return _broken
