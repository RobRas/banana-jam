extends Node2D

export(float) var period = 0.07
export(Vector2)	var magnitude = Vector2(50, 50)
export(float) var rot = 10
export(float) var duration = 0.7

var _camera

func _ready():
	_camera = get_tree().get_nodes_in_group("camera")[0]

func _on_need_shake(value):
	_camera.shake(period, magnitude * value, rot * value, duration)
