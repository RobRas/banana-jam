extends Node2D

export(float) var turn_speed = 5
export(bool) var broken

var _forward

var _player
var _turn_speed_rad

func _ready():
	set_speed(turn_speed)

func init(player):
	_player = player
	_forward = player.forward
	
	for child in get_children():
		if child.has_method("init"):
			child.init(_player)

func _process(delta):
	_keyboard_rotation(delta)

func _keyboard_rotation(delta):
	var rotation_input = 0
	if Input.is_action_pressed("rotate_clockwise"):
		rotation_input += 1
	if Input.is_action_pressed("rotate_counter_clockwise"):
		rotation_input -= 1
	
	var rotation_angle = rotation_input * _turn_speed_rad * delta
	
	for break_node in get_children():
		rotation_angle = break_node.modify_rotation_angle(delta, rotation_angle)
	
	_player.rotation += rotation_angle

func _mouse_rotation(delta):
	var target_direction = (get_global_mouse_position() - _player.global_position).normalized()
	var total_angle = _forward.get_forward().angle_to(target_direction)
	var frame_turn_speed = get_turn_speed_rad() * delta
	var rotation_angle = clamp(total_angle, -frame_turn_speed, frame_turn_speed)
	
	for break_node in get_children():
		rotation_angle = break_node.modify_rotation_angle(delta, rotation_angle, total_angle)
	
	_player.rotation += rotation_angle

func break_random():
	var breakable_children = []
	for child in get_children():
		if not child.is_broken():
			breakable_children.push_back(child)
	
	if breakable_children.size() == 0:
		return false
	
	var child_index = randi() % breakable_children.size()
	breakable_children[child_index].set_broken(true)
	print("Aim")
	return breakable_children[child_index].break_name
	

func set_speed(new_speed):
	_turn_speed_rad = deg2rad(new_speed)

func get_turn_speed_rad():
	return _turn_speed_rad

func is_fully_broken():
	for child in get_children():
		if not child.is_broken():
			return false
	return true
