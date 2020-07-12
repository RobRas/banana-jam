extends Node2D

export(NodePath) var targetting_path
var _targetting

signal shot(bullet)


func _ready():
	_targetting = get_node(targetting_path)
	
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("shot", world, "_on_player_shot")

func shoot(bullet_speed):
	var direction = _targetting.get_direction()
	var bullet_velocity = direction * bullet_speed
	var bullet = get_parent().bullet_scene.instance()
	emit_signal("shot", bullet)
	bullet.init(global_position, bullet_velocity)


func _on_shot_input(input_value):
	shoot(get_parent().bullet_speed)
