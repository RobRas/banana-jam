extends Node2D

export(bool) var broken

export(Vector2) var knockback_initial_speed = Vector2(1000, 1300)
export(Vector2) var knockback_duration = Vector2(0.7, 0.9)

var _player
var _broken = false

var _direction = Vector2()
var _added_speed = 0
var _previous_speed = 0

var _jumping = false


func init(player):
	_player = player
	set_broken(broken)

func set_broken(broken):
	if _broken == broken:
		return false
	
	_broken = broken
	return true

func _process(delta):
	if not _broken: 
		return
	
	_player.additional_velocity -= _direction * _previous_speed
	_player.additional_velocity += _direction * _added_speed
	_previous_speed = _added_speed
	_jumping = _added_speed != 0

func _knockback():
	if _jumping:
		_player.additional_velocity -= _direction * _previous_speed
	_jumping = true
	_direction = -_player.forward.get_forward()
	var strength = rand_range(0, 1)
	var duration = lerp(knockback_duration.x, knockback_duration.y, strength)
	var speed = lerp(knockback_initial_speed.x, knockback_initial_speed.y, strength)
	$SpeedTween.remove_all()
	$SpeedTween.interpolate_property(self, "_added_speed", speed, 0, duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$SpeedTween.start()

func enable():
	set_process(true)

func disable():
	set_process(false)


func _on_MouseClick_shot_input(input_value):
	_knockback()
