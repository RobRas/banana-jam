extends Node2D

export(bool) var broken = false
export(float) var speed = 15

var _broken = false
var _direction
var _player

func init(player):
	_player = player
	set_broken(broken)

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	return velocity

func set_broken(broken):
	if _broken == broken:
		return false
	
	_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
	_player.additional_velocity += _direction * speed
	_broken = broken
	return true

func is_broken():
	return _broken
