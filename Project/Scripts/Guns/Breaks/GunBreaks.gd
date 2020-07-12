extends Node2D


func init(player):
	for child in get_children():
		child.init(player)
		child.unequip()

func equip():
	for child in get_children():
		child.equip()

func unequip():
	for child in get_children():
		child.unequip()

func break_random():
	var breakable_children = []
	for child in get_children():
		if not child.is_broken():
			breakable_children.push_back(child)
	
	if breakable_children.size() == 0:
		return false
	
	var child_index = randi() % breakable_children.size()
	breakable_children[child_index].set_broken(true)

func is_fully_broken():
	for child in get_children():
		if not child.is_broken():
			return false
	return true
