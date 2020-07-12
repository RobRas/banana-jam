extends Node2D

func get_direction():
	return (get_global_mouse_position() - global_position).normalized()
