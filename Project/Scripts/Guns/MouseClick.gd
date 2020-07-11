extends Node2D


export(float) var cooldown = 0.5
var _current_cooldown = 0.0
var _player

signal shot_input(input_value)
signal smoke_create()

func init(player):
	_player = player
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("smoke_create", world, "_shotgun_smoke")

func _process(delta):
	_current_cooldown -= delta
	if Input.is_action_just_pressed("shoot") and _current_cooldown <= 0:
		_current_cooldown = cooldown
		emit_signal("shot_input", 1)
		emit_signal("smoke_create")
		$ShotgunSound.play()
