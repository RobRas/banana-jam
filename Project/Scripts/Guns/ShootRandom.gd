extends Node2D

export(float) var starting_angle = 120.0
export(float) var ending_angle = 0.0
export(float) var closing_time = 0.8
export(int) var bullet_count = 1

export(NodePath) var targetting_path
var _targetting

signal shot(bullet)

func _ready():
	_targetting = get_node(targetting_path)
	
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("shot", world, "_on_player_shot")

func shoot(bullet_speed, input_value):
	var max_angle
	if input_value == 0:
		max_angle = starting_angle / 2.0
	else:
		max_angle = (1.0 - input_value) * starting_angle / 2.0
	var front_direction = _targetting.get_direction()
	for _bullet_index in bullet_count:
		var angle = deg2rad(rand_range(-max_angle, max_angle))
		var direction = front_direction.rotated(angle)
		var bullet_velocity = direction * get_parent().bullet_speed
		var bullet = get_parent().bullet_scene.instance()
		emit_signal("shot", bullet)
		bullet.init(global_position, bullet_velocity)


func _on_shot_input(input_value):
	print("Shot")
	shoot(get_parent().bullet_speed, input_value)

