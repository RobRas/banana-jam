extends Node2D

export(bool) var broken = false
export(Vector2) var jump_initial_speed = Vector2(1200, 1500)
export(float) var jump_duration = 0.5
export(Vector2) var jump_cooldown = Vector2(6.0, 10.0)

var _broken = false

var _direction = Vector2()
var _added_speed = 0

func _ready():
	set_broken(broken)

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	return velocity + _direction * _added_speed

func set_broken(broken):
	if _broken == broken:
		return false

	_broken = broken
	jump()
	return true

func is_broken():
	return _broken


func _on_JumpCooldown_timeout():
	jump()

func jump():
	print("Jump")
	_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	var jump_speed = rand_range(jump_initial_speed.x, jump_initial_speed.y)
	$SpeedTween.remove_all()
	$SpeedTween.interpolate_property(self, "_added_speed", jump_speed, 0, jump_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$SpeedTween.start()
	
	yield($SpeedTween, "tween_completed")
	
	$JumpCooldown.wait_time = rand_range(jump_cooldown.x, jump_cooldown.y)
	$JumpCooldown.start()
