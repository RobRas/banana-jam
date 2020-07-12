extends Node2D

export(String) var break_name = "Power Hog"
export(bool) var broken
export(float) var end_speed_reduction = 0.1
export(float) var time_to_full_reduction = 6.0
export(float) var cooling_multiplier = 4.0

export(NodePath) var hold_path
var _hold_node

var _player

var _broken = false
var _equipped = false

var _time_held = 0.0
var _last_frame_reduction = 1.0

func _ready():
	_hold_node = get_node(hold_path)

func init(player):
	_player = player

func _process(delta):
	if not _broken:
		return
	if not _equipped:
		return
	
	if _hold_node.pressed:
		_time_held = min(_time_held + delta, time_to_full_reduction)
	else:
		_time_held = max(_time_held - (delta * cooling_multiplier), 0)
	
	var speed_reduction = lerp(1.0, end_speed_reduction, _time_held / time_to_full_reduction)
	
	var old = _player.get_max_speed()
	_player.set_max_speed(old / _last_frame_reduction)
	var fixed = _player.get_max_speed()
	_player.set_max_speed(fixed * speed_reduction)
	_last_frame_reduction = speed_reduction
	

func set_broken(broken):
	_broken = broken

func is_broken():
	return _broken

func equip():
	_time_held = 0
	_last_frame_reduction = 1.0
	_equipped = true

func unequip():
	var old = _player.get_max_speed()
	_player.set_max_speed(old / _last_frame_reduction)
	_equipped = false
