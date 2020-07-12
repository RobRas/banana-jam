extends Node2D


export(float) var cooldown = 0.2
var _current_cooldown = 0.0
var _player
signal shot_input(input_value)
signal gatling_smoke_create()

var pressed = false

func init(player):
	_player = player
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("gatling_smoke_create", world, "_gatling_smoke")
	
func _process(delta):
	pressed = false
	_current_cooldown -= delta
	if Input.is_action_pressed("shoot"):
		pressed = true
		if  _current_cooldown <= 0:
			_current_cooldown = cooldown
			emit_signal("shot_input", 1)
			emit_signal("gatling_smoke_create")

func modify_cooldown(value):
	if pressed:
		_current_cooldown -= value

func equip():
	set_process(true)

func unequip():
	pressed = false
	set_process(false)
