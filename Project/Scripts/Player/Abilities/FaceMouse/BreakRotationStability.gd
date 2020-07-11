extends Node2D


export(bool) var broken
export(float) var max_turn = 1.2
export(float) var speed = 250

var _noise = OpenSimplexNoise.new()
var _time = 0.0

var _broken = false
var _max_turn_rads

func _ready():
	set_broken(broken)
	_max_turn_rads = deg2rad(max_turn)

func set_broken(broken):
	if _broken == broken:
		return false

	_broken = true
	_noise.seed = randi()
	_noise.octaves = 3
	return true

func modify_rotation_angle(delta, angle):
	if not _broken:
		return angle
	
	angle += _noise.get_noise_1d(_time * speed) * _max_turn_rads
	_time += delta
	return angle

func is_broken():
	return _broken
