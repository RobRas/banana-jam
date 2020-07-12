extends Node


func _on_bullet_hit(body):
	get_parent().queue_free()
