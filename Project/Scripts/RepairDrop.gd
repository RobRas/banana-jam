extends Node2D

signal repair_pickup
var value_repaired = 2

func init(value_repaired, drop_position):
	value_repaired = value_repaired
	global_position = drop_position

func destroy():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.has_method("scrap_hit"):
		body.scrap_hit(self, value_repaired)
