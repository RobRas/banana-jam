extends Node2D

export(bool) var broken = false
export(float) var accel_modifier = 0.2
export(float) var friction_modifier = 0.4 # feels better with less friction

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
	
	get_parent().acceleration *= accel_modifier
	get_parent().friction *= friction_modifier
	_broken = broken
	return true

func is_broken():
	return _broken
