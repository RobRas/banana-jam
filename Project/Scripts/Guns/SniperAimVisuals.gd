extends Node2D

export(NodePath) var input_path
var input

export(NodePath) var shoot_path
var shoot

var _holding = false

var _min_angle
var _max_angle
var _player

func _ready():
	input = get_node(input_path)
	shoot = get_node(shoot_path)
	_max_angle = shoot.starting_angle
	_min_angle = shoot.ending_angle

func init(player):
	_player = player

func _process(delta):
	if not _holding:
		return
	var angle = lerp(_max_angle, _min_angle, input.get_percent_held())
	print(input.get_percent_held())
	$Left.rotation_degrees = global_rotation + angle / 2.0
	$Right.rotation_degrees = global_rotation - angle / 2.0


func unequip():
	_holding = false
	visible = false


func _on_MouseHoldAndRelease_hold_started():
	_holding = true
	visible = true


func _on_MouseHoldAndRelease_shot_input(input_value):
	_holding = false
	visible = false
