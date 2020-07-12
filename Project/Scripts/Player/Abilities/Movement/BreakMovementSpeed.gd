extends Node2D

export(String) var break_name = "Failing Engine"
export(String) var break_description = "Changing speed"
export(bool) var broken = false
export(float) var speed = 20
export(Vector2) var max_speed_modifier = Vector2(0.7, 1.1)

var _noise = OpenSimplexNoise.new()

var _time = 0
var _broken = false
var _initial_max_speed
var _player

func init(player):
	_initial_max_speed = get_parent().max_speed
	_noise.octaves = 3
	_noise.period = 0.5

func _process(delta):
	_time += delta

func modify_velocity(velocity, forward):
	if not _broken:
		return velocity
	
	var val = _noise.get_noise_1d(_time)
	var new_max_speed = map(val, Vector2(-1, 1), max_speed_modifier) * _initial_max_speed
	get_parent().max_speed = new_max_speed
	
	return velocity

func set_broken(broken):
	_broken = broken
	_noise.seed = randi()
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func is_broken():
	return _broken

func map(val, from, to):
	return to.x + ((to.y - to.x) / (from.y - from.x)) * (val - from.x)
