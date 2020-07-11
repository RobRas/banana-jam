extends Node


func _on_Area2D_area_entered(area):
	#emit_signal("enemy_hit",$Sprite.global_position)
	get_parent().queue_free()
