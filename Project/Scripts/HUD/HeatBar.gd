extends TextureProgress

export(Texture) var danger_bar_texture
export(Vector2) var scale_to = Vector2(1.05, 1.25)
export(float) var scale_speed = 0.2
export(Vector2) var flash_speed = Vector2(0.12, 0.05)
var _danger = false

var _default_bar_texture

func _ready():
	_default_bar_texture = texture_progress

func set_danger(danger):
	_danger = danger
	if _danger:
		texture_progress = danger_bar_texture
		_flash_up()
		_scale_up()
	else:
		texture_progress = _default_bar_texture
		modulate = Color.white
		rect_scale = Vector2(1.0, 1.0)
		$Up.stop()
		$Down.stop()
		$FlashUp.stop()
		$FlashDown.stop()

func _get_value(vals):
	var i = value / max_value
	return lerp(vals.x, vals.y, i)

func _on_Up_tween_all_completed():
	$Down.interpolate_property(self, "rect_scale", Vector2(1.0, 1.0), Vector2(_get_value(scale_to), _get_value(scale_to)), scale_speed, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Down.start()


func _on_Down_tween_all_completed():
	_scale_up()


func _on_FlashUp_tween_all_completed():
	$FlashDown.interpolate_property(self, "modulate", Color.red, Color.white, _get_value(flash_speed), Tween.TRANS_EXPO, Tween.EASE_IN)
	$FlashDown.start()


func _on_FlashDown_tween_all_completed():
	_flash_up()

func _scale_up():
	$Up.interpolate_property(self, "rect_scale", Vector2(_get_value(scale_to), _get_value(scale_to)), Vector2(1.0, 1.0), scale_speed, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Up.start()

func _flash_up():
	$FlashUp.interpolate_property(self, "modulate", Color.white, Color.red, _get_value(flash_speed), Tween.TRANS_EXPO, Tween.EASE_IN)
	$FlashUp.start()
