extends Node2D

export(bool) var broken
export(float) var forgiveness = 10

var _broken = false
var _direction = -1
var _forgiveness_rad = 0


func _ready():
	_forgiveness_rad = deg2rad(forgiveness)
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
		new_angle = get_parent().get_turn_speed_rad() * delta * -_direction
	elif abs(total_angle) < _forgiveness_rad:
		new_angle = 0
	
	return new_angle

func is_broken():
	return _broken
