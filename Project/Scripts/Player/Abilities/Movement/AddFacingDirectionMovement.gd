extends Node2D

export(bool) var broken = false
export(float) var speed = 100

var _broken
var _direction

func _ready():
	set_broken(broken)

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	var rotation_angle = Vector2(0, 1).angle_to(forward.get_forward())
	velocity += _direction.rotated(rotation_angle) * speed
	return velocity

func set_broken(broken):
	if _broken == broken:
		return false
	
	var direction_scalar = -1 if (randi() % 2) == 0 else 1
	_direction = Vector2(direction_scalar, 0)
	_broken = broken
	return true

func is_broken():
	return _broken
