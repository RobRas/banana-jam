extends Node2D

signal repair_pickup
var _value_repaired

func init(value_repaired, drop_position):
	_value_repaired = value_repaired
	self.global_position = drop_position
	

func _on_Area2D_area_entered(area):
	emit_signal("repair_pickup", _value_repaired)
	queue_free()
