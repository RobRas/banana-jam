extends Node2D

export(bool) var broken = false
export(float) var modifier = 0.2

var _broken = false

func _process(delta):
	#to wait for parent to ready
	set_broken(broken)
	set_process(false)

func modify_velocity(velocity, forward):
	return velocity

func set_broken(broken):
	if _broken == broken:
		return false
	
	get_parent().friction *= modifier
	_broken = broken
	return true

func is_broken():
	return _broken
