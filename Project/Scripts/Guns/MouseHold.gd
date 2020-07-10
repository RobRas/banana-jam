extends Node2D


export(float) var cooldown = 0.2
var _current_cooldown = 0.0

signal shot_input


func _process(delta):
	_current_cooldown -= delta
	if Input.is_action_pressed("shoot") and _current_cooldown <= 0:
		_current_cooldown = cooldown
		emit_signal("shot_input")
