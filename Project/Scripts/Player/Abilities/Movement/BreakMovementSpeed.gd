extends Node2D

export(bool) var broken = false
export(float) var modifier = 0.6

var _broken

func _ready():
	set_broken(broken)

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	return velocity * modifier

func set_broken(broken):
	if _broken == broken:
		return false
	
	_broken = broken
	return true

func is_broken():
	return _broken
