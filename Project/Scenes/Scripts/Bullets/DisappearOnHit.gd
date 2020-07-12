extends Node


func _on_BulletLight_hit(body):
	get_parent().queue_free()
