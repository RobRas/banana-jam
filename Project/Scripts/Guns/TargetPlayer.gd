extends Node

func get_direction():
	print(get_parent().global_position)
	return get_parent().global_position.direction_to(get_tree().get_nodes_in_group("players")[0].global_position)
