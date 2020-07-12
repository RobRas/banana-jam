extends Node

signal Baddie_dead
export (int) var drop_value = 1;

func _on_Area2D_area_entered(area):
	#emit_signal("enemy_hit",$Sprite.global_position)
	emit_signal("Baddie_dead", drop_value, get_parent().global_position)
	get_parent().queue_free()
