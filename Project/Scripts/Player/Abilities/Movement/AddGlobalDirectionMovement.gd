extends Node2D

export(bool) var broken = false
export(float) var speed = 80

var _broken
var _direction

func _ready():
	set_broken(broken)

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	return velocity + _direction * speed

func set_broken(broken):
	if _broken == broken:
		return false
	
	_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
	_broken = broken
	return true

func is_broken():
	return _broken
