extends Node2D

export(String) var break_name = "Rotation Slowdown"
export(bool) var broken = false
export(float) var speed = 100

var _broken = false
var _direction
var _player

var _last_add = Vector2()

func init(player):
	_player = player

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	_player.additional_velocity -= _last_add
	var rotation_angle = Vector2(0, 1).angle_to(forward.get_forward())
	_last_add = _direction.rotated(rotation_angle) * speed
	_player.additional_velocity += _last_add
	return velocity

func set_broken(broken):
	_broken = broken
	var direction_scalar = -1 if (randi() % 2) == 0 else 1
	_direction = Vector2(direction_scalar, 0)
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func is_broken():
	return _broken
