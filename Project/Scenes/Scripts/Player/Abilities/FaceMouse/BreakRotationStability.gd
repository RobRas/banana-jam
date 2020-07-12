extends Node2D

export(String) var break_name = "Rotation Slowdown"
export(bool) var broken
export(float) var max_turn = 1.2
export(float) var speed = 250

var _noise = OpenSimplexNoise.new()
var _time = 0.0

var _broken = false
var _max_turn_rads

func _ready():
	_max_turn_rads = deg2rad(max_turn)

func set_broken(broken):
	_broken = broken
	_noise.seed = randi()
	_noise.octaves = 3
	if _broken:
		print("Break: " + break_name + "!")
	else:
		print("Repaired: " + break_name + "!")

func modify_rotation_angle(delta, angle):
	if not _broken:
		return angle
	
	angle += _noise.get_noise_1d(_time * speed) * _max_turn_rads
	_time += delta
	return angle

func is_broken():
	return _broken
