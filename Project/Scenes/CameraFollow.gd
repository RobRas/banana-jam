extends Node2D

export(NodePath) var to_follow_path
export(float) var follow_ease = 0.03

var _to_follow

func _ready():
	_to_follow = get_node(to_follow_path)
	global_position = _to_follow.global_position

func _process(delta):
	global_position = lerp(global_position, _to_follow.global_position, follow_ease)
