extends Node2D


var _player

func init(player):
	_player = player

func get_direction():
	return _player.get_node("Forward").get_forward()
