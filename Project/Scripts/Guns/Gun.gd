extends Node2D

export(PackedScene) var bullet_scene
export(float) var bullet_speed

signal shot(bullet)


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


func _on_shot(bullet):
	emit_signal("shot", bullet)
