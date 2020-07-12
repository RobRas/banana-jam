extends Node

signal Baddie_dead
export (int) var drop_value = 1;

func damage(_damage):
	emit_signal("Baddie_dead", drop_value, get_parent().global_position)
	get_parent().queue_free()
