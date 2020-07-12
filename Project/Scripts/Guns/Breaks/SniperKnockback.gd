extends Node2D

export(String) var break_name = "Exploding Backblast"
export(String) var break_description = "Sniper: Knockback from charge"
export(bool) var broken
export(Vector2) var minor_knockback = Vector2(300, 1000)
export(Vector2) var knockback_initial_speed = Vector2(300, 50000)
export(Vector2) var knockback_duration = Vector2(0.3, 2.5)
export(NodePath) var shoot_path

export(NodePath) var camera_shake_path
var camera_shake

export(float) var period = 0.07
export(Vector2)	var magnitude = Vector2(25, 25)
export(float) var rot = 7
export(float) var duration = 0.6

export(float) var break_period = 0.07
export(Vector2)	var break_magnitude = Vector2(50, 50)
export(float) var break_rot = 10
export(float) var break_duration = 0.7
var _shoot

var _player
var _broken = false
var _equipped = false

var _direction = Vector2()
var _added_speed = 0
var _previous_speed = 0

var _knockback_value

func init(player):
	camera_shake = get_node(camera_shake_path)
	_knockback_value = minor_knockback
	_player = player
	_shoot = get_node(shoot_path)

func set_broken(broken):
	_broken = broken
	if _broken:
		_knockback_value = knockback_initial_speed
		camera_shake.period = break_period
		camera_shake.magnitude = break_magnitude
		camera_shake.rot = break_rot
		camera_shake.duration = break_duration
	else:
		_knockback_value = minor_knockback
		camera_shake.period = period
		camera_shake.magnitude = magnitude
		camera_shake.rot = rot
		camera_shake.duration = duration

func _process(delta):
	_player.additional_velocity -= _direction * _previous_speed
	_player.additional_velocity += _direction * _added_speed
	_previous_speed = _added_speed
	
	if _added_speed == 0:
		_shoot.self_enabled = true

func _knockback(value):
	_shoot.self_enabled = false
	_direction = -_player.forward.get_forward()
	_added_speed = 0
	_previous_speed = 0
	
	var strength = value
	var duration = lerp(knockback_duration.x, knockback_duration.y, strength)
	var speed = lerp(_knockback_value.x, _knockback_value.y, strength)
	
	_added_speed = speed
	$SpeedTween.remove_all()
	$SpeedTween.interpolate_property(self, "_added_speed", speed, 0, duration, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$SpeedTween.start()

func equip():
	_equipped = true

func unequip():
	_equipped = false

func is_broken():
	return _broken

func _on_MouseClick_shot_input(input_value):
	if _equipped:
		_knockback(input_value)
