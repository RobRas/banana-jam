extends Node2D

export(String) var break_name = "Exploding Backblast"
export(String) var break_description = "Sniper: Knockback from charge"
export(bool) var broken
export(Vector2) var knockback_initial_speed = Vector2(300, 50000)
export(Vector2) var knockback_duration = Vector2(0.3, 2.5)
export(NodePath) var shoot_path
var _shoot

var _player
var _broken = false
var _equipped = false

var _direction = Vector2()
var _added_speed = 0
var _previous_speed = 0


func init(player):
	_player = player
	_shoot = get_node(shoot_path)
	set_broken(true)

func set_broken(broken):
	_broken = broken

func _process(delta):
	if not _broken: 
		return
	
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
	var speed = lerp(knockback_initial_speed.x, knockback_initial_speed.y, strength)
	
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
	if _equipped and _broken:
		_knockback(input_value)