extends Node2D


export(bool) var broken
export(float) var offset_min = 18
export(float) var offset_max = 30

var _broken = false
var _offset_rads

var _player

func init(player):
	_player = player
	set_broken(broken)

func set_broken(broken):
	if _broken == broken:
		return false
	
	_broken = broken
	var offset_direction = 1 if (randi() % 2) == 1 else -1
	var offset = offset_direction * rand_range(offset_min, offset_max)
	_player.forward.position.y += offset
	return true

func modify_rotation_angle(delta, angle):
	return angle

func is_broken():
	return _broken
