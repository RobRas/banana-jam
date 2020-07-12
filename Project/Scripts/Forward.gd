extends Position2D

export(NodePath) var base_node_path
var _base_node


func _ready():
	_base_node = get_node(base_node_path)

func get_forward():
	return (global_position - _base_node.global_position).normalized()
