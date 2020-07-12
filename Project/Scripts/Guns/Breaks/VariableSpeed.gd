extends Node2D

export(String) var break_name = "Clogged Pipes"
export(bool) var broken
export(Vector2) var cooldown_mod = Vector2(-0.5, 0.1)
export(float) var frequency = 200

export(NodePath) var hold_path
var _hold_node

var _player

var _broken = false
var _equipped = false

var _time = 0.0

var _noise = OpenSimplexNoise.new()

func _ready():
	_hold_node = get_node(hold_path)
	_noise.octaves = 2
	_noise.period = 0.6

func init(player):
	_player = player

func _process(delta):
	if not _broken:
		return

	_time += delta
	var noise = abs(_noise.get_noise_1d(_time))
	var cooldown = lerp(cooldown_mod.x, cooldown_mod.y, noise)
	
	_hold_node.modify_cooldown(cooldown * delta)
	
	

func set_broken(broken):
	_broken = broken

func is_broken():
	return _broken

func equip():
	_equipped = true

func unequip():
	_equipped = false
