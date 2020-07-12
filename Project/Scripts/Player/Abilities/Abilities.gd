extends Node2D


func break_random():
	var breakable_types = []
	for break_type in get_children():
		if not break_type.is_fully_broken():
			breakable_types.push_back(break_type)
	
	var i = randi() % breakable_types.size()
	return breakable_types[i].break_random()
