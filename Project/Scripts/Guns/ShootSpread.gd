extends Node2D


export(int) var bullet_count = 5
export(int) var angle = 30

export(NodePath) var targetting_path
var _targetting

signal shot(bullet)

var _angle_increment

func _ready():
	_angle_increment = deg2rad(angle / (bullet_count - 1))
	_targetting = get_node(targetting_path)
	
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("shot", world, "_on_player_shot")

func shoot(bullet_speed):
	var front_direction = _targetting.get_direction()
	var direction = front_direction.rotated(-deg2rad(angle / 2.0))
	for _bullet_index in bullet_count:
		var bullet_velocity = direction * get_parent().bullet_speed
		var bullet = get_parent().bullet_scene.instance()
		emit_signal("shot", bullet)
		bullet.init(global_position, bullet_velocity)
		direction = direction.rotated(_angle_increment)


func _on_shot_input(input_value):
	shoot(get_parent().bullet_speed)
