extends Node2D

export(String) var break_name = "Foggy Scope"
export(String) var break_description = "Sniper: Slow charge while moving"
export(bool) var broken

export(NodePath) var hold_path
var _hold_node

var _player

var _broken = false
var _equipped = false

func _ready():
	_hold_node = get_node(hold_path)

func init(player):
	_player = player

func _process(delta):
	if not _broken:
		return
	_hold_node.set_frozen(_player.velocity.length_squared() > 100)

func set_broken(broken):
	_broken = broken
	if not _broken:
		_hold_node.set_frozen(false)

func is_broken():
	return _broken

func equip():
	_equipped = true

func unequip():
	_equipped = false
