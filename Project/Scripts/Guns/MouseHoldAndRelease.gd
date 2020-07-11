extends Node2D


export(float) var cooldown = 0.2
var _current_cooldown = 0.0

export(float) var max_hold_time = 0.8
export(float) var min_hold_time = 0.3
var _current_hold_time = 0.0

export(float) var forgiveness = 0.15

signal shot_input(input_value)


func _process(delta):
	_current_cooldown -= delta
	if Input.is_action_just_pressed("shoot"):
		_current_hold_time = 0.0
	
	if Input.is_action_pressed("shoot") and _current_cooldown <= 0.0:
			_current_hold_time += delta
	
	if Input.is_action_just_released("shoot"):
		_current_cooldown = cooldown
		_current_hold_time = 0.0
		if _current_hold_time < min_hold_time:
			pass
		elif _current_hold_time > max_hold_time:
			pass
		else:
			var percent_held = (_current_hold_time - min_hold_time) / (max_hold_time - min_hold_time)
			percent_held = min(percent_held + forgiveness, 1.0)
			emit_signal("shot_input", percent_held)

func enable():
	set_process(true)

func disable():
	_current_hold_time = 0.0
	set_process(false)
