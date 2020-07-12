extends Node2D

export(String) var break_name = "Rotation Slowdown"
export(bool) var broken = false
export(float) var speed = 15

var _broken = false
var _direction = Vector2()
var _player

func init(player):
	_player = player

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	return velocity

func set_broken(broken):
	_broken = broken
	if _broken:
		_player.additional_velocity -= _direction * speed
		_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
		_player.additional_velocity += _direction * speed
	else:
		_player.additional_velocity -= _direction * speed
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func is_broken():
	return _broken
