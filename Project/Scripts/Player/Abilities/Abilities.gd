extends Node2D

var broken_parts = []

func break_random():
	var breakable_types = []
	for break_type in get_children():
		if not break_type.is_fully_broken():
			breakable_types.push_back(break_type)
	
	if breakable_types.size() == 0:
		printerr("No more breaks")
		return null
	
	var i = randi() % breakable_types.size()
	var broken_part = breakable_types[i].break_random()
	broken_parts.push_back(broken_part)
	return broken_part.break_name

func unbreak_part():
	if broken_parts.empty() != true:
		var part = broken_parts.pop_front()
		part.set_broken(false)
		return part.break_name
