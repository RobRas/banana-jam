extends Node2D


export(float) var cooldown = 0.5
var _current_cooldown = 0.0
var _player

signal shot_input(input_value)

func init(player):
	_player = player

func _process(delta):
	_current_cooldown -= delta
	if Input.is_action_just_pressed("shoot") and _current_cooldown <= 0:
		_current_cooldown = cooldown
		emit_signal("shot_input", 1)
