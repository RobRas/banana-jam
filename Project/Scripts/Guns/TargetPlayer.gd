extends Node

func get_direction():
	return get_parent().global_position.direction_to(get_tree().get_nodes_in_group("players")[0].global_position)
