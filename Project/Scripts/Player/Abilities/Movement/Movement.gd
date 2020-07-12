extends Node2D

export(bool) var broken

export(float) var max_speed = 250
export(float) var acceleration = 400
export(float) var friction = 400

var _player
var _forward

func init(player):
	_player = player
	_forward = _player.forward
	for child in get_children():
		if child.has_method("init"):
			child.init(_player)

func _process(delta):
	var acceleration_delta = acceleration * delta
	var friction_delta = friction * delta
	
	var input_direction = _get_input()
	var player_direction = _player.velocity.normalized()
	
	var velocity_change = Vector2()
	
	if input_direction.x != 0:
		velocity_change.x = input_direction.x * acceleration_delta
	else:
		velocity_change.x = -player_direction.x * min(friction_delta, abs(_player.velocity.x))
	
	if input_direction.y != 0:
		velocity_change.y = input_direction.y * acceleration_delta
	else:
		velocity_change.y = -player_direction.y * min(friction_delta, abs(_player.velocity.y))

	var target_velocity = _player.velocity + velocity_change
	if target_velocity.length_squared() > pow(max_speed, 2):
		target_velocity = target_velocity.normalized() * max_speed
	
	for break_node in get_children():
		target_velocity = break_node.modify_velocity(target_velocity, _forward)
	
	_player.velocity = target_velocity


func _get_input():
	return _get_input_keyboard()

func _get_input_keyboard():
	var input_direction = 0
	if Input.is_action_pressed("move_forward"):
		input_direction += 1
	if Input.is_action_pressed("move_backward"):
		input_direction -= 1
	return _player.forward.get_forward() * input_direction
	
func _get_input_mouse():
	var input_direction = Vector2()
	if Input.is_action_pressed("move_down"):
		input_direction += Vector2(0, 1)
	if Input.is_action_pressed("move_up"):
		input_direction -= Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		input_direction -= Vector2(1, 0)
	if Input.is_action_pressed("move_right"):
		input_direction += Vector2(1, 0)
	
	return input_direction.normalized()


func break_random():
	var breakable_children = []
	for child in get_children():
		if not child.is_broken():
			breakable_children.push_back(child)
	
	if breakable_children.size() == 0:
		return false
	
	var child_index = randi() % breakable_children.size()
	breakable_children[child_index].set_broken(true)

func is_fully_broken():
	for child in get_children():
		if not child.is_broken():
			return false
	return true
