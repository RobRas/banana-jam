extends Node2D


export(float) var speed_modifier = 0.5
var _broken = false

func set_broken(broken):
	if _broken == broken:
		return false
	
	_broken = broken
	return true

func modify_rotation_angle(delta, angle, total_angle):
	if not _broken:
		return angle
	
	return angle / speed_modifier

func is_broken():
	return _broken
