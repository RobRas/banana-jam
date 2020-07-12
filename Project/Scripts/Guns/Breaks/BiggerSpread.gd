extends Node2D

export(String) var break_name = "Blasted Barrel"
export(bool) var broken
export(float) var angle_increase = 60
export(NodePath) var spread_path
var _spread_node

var _player

var _broken = false
var _equipped = false

var _direction = Vector2()

func _ready():
	_spread_node = get_node(spread_path)

func init(player):
	_player = player

func set_broken(broken):
	_broken = broken
	if _broken:
		_spread_node.angle += angle_increase
	else:
		_spread_node.angle -= angle_increase

func is_broken():
	return _broken

func equip():
	_equipped = true

func unequip():
	_equipped = false
