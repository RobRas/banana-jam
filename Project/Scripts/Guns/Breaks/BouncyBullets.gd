extends Node2D

export(String) var break_name = "Too Metal Jackets"
export(bool) var broken

var _broken = true
var _equipped = false


func set_broken(broken):
	_broken = broken

func is_broken():
	return _broken

func equip():
	_equipped = true

func unequip():
	_equipped = false


func _on_Shoot_shot(bullet):
	if not _broken:
		return
	bullet.set_enemy_bounce()
