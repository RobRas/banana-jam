extends Node2D


func init(player):
	for child in get_children():
		child.init(player)
		child.disable()

func enable():
	for child in get_children():
		child.enable()

func disable():
	for child in get_children():
		child.disable()
