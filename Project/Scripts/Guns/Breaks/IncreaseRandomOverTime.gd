extends Node2D

export(String) var break_name = "Weak Arms"
export(bool) var broken
export(float) var max_angle = 140
export(float) var time_to_max = 8.0
export(float) var cooling_multiplier = 2.0

export(NodePath) var hold_path
var _hold_node

export(NodePath) var shoot_path
var _shoot

var _player

var _broken = false
var _equipped = false

var _time_held = 0.0

func _ready():
	_hold_node = get_node(hold_path)
	_shoot = get_node(shoot_path)

func init(player):
	_player = player

func _process(delta):
	if not _broken:
		return
	
	if _hold_node.pressed:
		_time_held += delta
		_shoot.static_value = 1 - min(_time_held / time_to_max, 1)
	else:
		_time_held = max(_time_held - (delta * cooling_multiplier), 0)
		
		

func set_broken(broken):
	_broken = broken
	if _broken:
		_shoot.use_given_input = false
		_shoot.starting_angle += max_angle
	else:
		_shoot.use_given_input = true
		_shoot.starting_angle -= max_angle

func is_broken():
	return _broken

func equip():
	_equipped = true

func unequip():
	_equipped = false
