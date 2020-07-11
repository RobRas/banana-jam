extends Node2D

export(bool) var broken

var _broken = false
var _direction = -1


func _ready():
	set_broken(broken)

func set_broken(broken):
	if _broken == broken:
		return false
	
	_direction = -1 if (randi() % 2) == 0 else 1
	_broken = broken
	return true

func modify_rotation_angle(delta, angle, total_angle):
	if not _broken:
		return angle
	
	var new_angle = angle
	print(new_angle)
	
	if sign(angle) == _direction:
		return 0
	
	return angle

func is_broken():
	return _broken
