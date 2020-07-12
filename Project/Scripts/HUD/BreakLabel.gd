extends Label

export(float) var movement_duration = 0.2

export(float) var scale_start = 5.0
export(float) var shake_duration = 0.8
export(float) var shake_frequency = 500
export(float) var shake_magnitude = 300
export(float) var shake_rot_frequency = 500
export(float) var shake_rot_magnitude = 200

export(float) var flash_duration = 2.5
export(float) var flash_frequency = 600

var _noise = OpenSimplexNoise.new()

var _movement_value = 0
var _shake_value = 0
var _flash_value = 0

var _time = 0
var initial_pos

var _flashing = true

func _ready():
	_noise.period = 0.1
	initial_pos = rect_position
	rect_scale = Vector2(scale_start, scale_start)
	$Movement.interpolate_property(self, "_movement_value", 0, 1, movement_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Movement.start()
	
	$Shake.interpolate_property(self, "_shake_value", 0, 1, shake_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Shake.start()
	
	$Shake.interpolate_property(self, "_flash_value", 0, 1, flash_duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Shake.start()
	
	

func _process(delta):
	_time += delta
	
	var new_scale = lerp(scale_start, 1.0, _movement_value)
	margin_left = lerp(-500.0, 0.0, _movement_value)
	rect_scale = Vector2(new_scale, new_scale)
		
	var shake_move_x = _noise.get_noise_1d(_time) * shake_magnitude
	var shake_move_y = _noise.get_noise_1d((_time + 1000)) * shake_magnitude
		
	shake_move_x = lerp(shake_move_x, 3 * sign(shake_move_x), _shake_value)
	shake_move_y = lerp(shake_move_y, 3 * sign(shake_move_x), _shake_value)
		
	margin_left += shake_move_x
	margin_bottom += shake_move_y
	
	var shake_rot = _noise.get_noise_1d((_time + 2000)) * shake_rot_magnitude
	rect_rotation = lerp(shake_rot, 2.0 * sign(shake_rot), _shake_value)
	
	var flash = abs(_noise.get_noise_1d((_time + 3000)))
	var color = lerp(Color(1.0, 0.0, 0.0, 1.0), Color(1.0, 1.0, 1.0, 1.0), flash)
	modulate = color
