extends Node2D

export(bool) var broken

var _current_gun_index = 0
var _current_gun


func _ready():
	_current_gun = get_child(_current_gun_index)

func init(player):
	for gun in get_children():
		if gun.has_method("init"):
			gun.init(player)
	get_child(_current_gun_index).enable()

func _process(delta):
	if Input.is_action_just_pressed("switch_gun"):
		_next_gun()

func _next_gun():
	_current_gun.disable()
	_current_gun_index = (_current_gun_index + 1) % get_child_count()
	_current_gun = get_child(_current_gun_index)
	_current_gun.enable()

func break_operation():
	var breakable_children = []
	for child in get_children():
		if not child.is_broken():
			breakable_children.push_back(child)
	
	if breakable_children.len == 0:
		return false
	
	var child_index = randi() % breakable_children.len
	return breakable_children.set_broken(true)
