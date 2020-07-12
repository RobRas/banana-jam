extends Node2D

export(String) var break_name = "Leaking Oil"
export(String) var break_description = "Random bursts of movement"
export(bool) var broken = false
export(Vector2) var jump_initial_speed = Vector2(1200, 1500)
export(float) var jump_duration = 0.5
export(Vector2) var jump_cooldown = Vector2(6.0, 10.0)

var _broken = false

var _direction = Vector2()
var _added_speed = 0


func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	return velocity + _direction * _added_speed

func set_broken(broken):
	_broken = broken
	$JumpCooldown.wait_time = rand_range(jump_cooldown.x, jump_cooldown.y)
	$JumpCooldown.start()
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func is_broken():
	return _broken


func _on_JumpCooldown_timeout():
	jump()

func jump():
	_direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	var jump_speed = rand_range(jump_initial_speed.x, jump_initial_speed.y)
	$SpeedTween.remove_all()
	$SpeedTween.interpolate_property(self, "_added_speed", jump_speed, 0, jump_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$SpeedTween.start()
	
	yield($SpeedTween, "tween_completed")
	
	$JumpCooldown.wait_time = rand_range(jump_cooldown.x, jump_cooldown.y)
	$JumpCooldown.start()
