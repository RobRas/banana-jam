extends Node2D

export(PackedScene) var bullet_scene
export(float) var bullet_speed


func init(player):
	for child in get_children():
		if child.has_method("init"):
			child.init(player)
	disable()


func enable():
	for child in get_children():
		if child.has_method("enable"):
			child.enable()

func disable():
	for child in get_children():
		if child.has_method("disable"):
			child.disable()
