extends Node2D

var _current_gun_index = 0
var _current_gun

func _ready():
	_current_gun = get_child(_current_gun_index)

func init(player):
	for gun in get_children():
		if gun.has_method("init"):
			gun.init(player)
	get_child(_current_gun_index).equip()

func _process(delta):
	if Input.is_action_just_pressed("switch_gun"):
		_next_gun()

func _next_gun():
	_current_gun.unequip()
	_current_gun_index = (_current_gun_index + 1) % get_child_count()
	_current_gun = get_child(_current_gun_index)
	_current_gun.equip()

func break_random():
	var breakable_guns = []
	for gun in get_children():
		if not gun.is_fully_broken():
			breakable_guns.push_back(gun)
	
	var gun_index = randi() % breakable_guns.size()
	breakable_guns[gun_index].break_random()

func is_fully_broken():
	for child in get_children():
		if not child.is_fully_broken():
			return false
	return true
