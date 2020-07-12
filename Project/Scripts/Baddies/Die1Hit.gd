extends Node

signal Baddie_dead(value, position)
export (int) var drop_value = 1;
export (int) var baddie_hp = 3;

func damage(_damage):
	baddie_hp -= _damage;
	if baddie_hp <= 0:
		emit_signal("Baddie_dead", drop_value, get_parent().global_position)
		get_parent().queue_free()
