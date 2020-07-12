extends Camera2D

var _noise = OpenSimplexNoise.new()
var _shake_i = 0.0
var _time = 0.0

var _magnitude
var _rot


func _process(delta):
	if _shake_i <= 0:
		return
	
	_time += delta
	var x = _noise.get_noise_1d(_time) * _magnitude.x
	var y = _noise.get_noise_1d(_time + 2000) * _magnitude.y
	var r = _noise.get_noise_1d(_time + 5000) * _rot
	
	x = lerp(x, 0, _shake_i)
	y = lerp(y, 0, _shake_i)
	r = lerp(r, 0, _shake_i)
	
	offset = Vector2(x, y)
	rotation_degrees = r

func shake(period, magnitude, rot, duration):
	_noise.period = period
	_magnitude = magnitude
	_rot = rot
	$ShakeTween.stop_all()
	$ShakeTween.interpolate_property(self, "_shake_i", 0.0, 1.0, duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$ShakeTween.start()


func _on_Player_part_broken(break_node):
	shake(0.07, Vector2(70, 70), 14.0, 0.8)
