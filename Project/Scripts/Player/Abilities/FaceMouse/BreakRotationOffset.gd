extends Node2D


export(bool) var broken
export(float) var offset_min = 15
export(float) var offset_max = 30

var _broken = false
var _offset_rads

func _ready():
	set_broken(broken)

func set_broken(broken):
	if _broken == broken:
		return false
	
	_broken = broken
	var offset_direction = 1 if (randi() % 2) == 1 else -1
	var offset_degrees = rand_range(offset_min, offset_max)
	var offset = deg2rad(offset_degrees) * offset_direction
	get_parent().offset = offset
	return true

func modify_rotation_angle(delta, angle, total_angle):
	return angle

func is_broken():
	return _broken
