extends Node2D

export(String) var break_name = "Rotation Slowdown"
export(bool) var broken
export(float) var offset_min = 18
export(float) var offset_max = 30

var _broken = false
var _offset_rads
var _offset = 0

var _player

func init(player):
	_player = player

func set_broken(broken):
	_broken = broken
	if _broken:
		var offset_direction = 1 if (randi() % 2) == 1 else -1
		_offset = offset_direction * rand_range(offset_min, offset_max)
		_player.forward.position.y += _offset
	else:
		_player.forward.position.y -= _offset
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func modify_rotation_angle(delta, angle):
	return angle

func is_broken():
	return _broken
