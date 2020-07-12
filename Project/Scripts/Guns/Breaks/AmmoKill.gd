extends Node2D

export(String) var break_name = "Crumbling Pellets"
export(bool) var broken
export(Vector2) var lifetime = Vector2(0.05, 0.5)

var _broken = false
var _equipped = false


func set_broken(broken):
	_broken = broken

func is_broken():
	return _broken

func equip():
	_equipped = true

func unequip():
	_equipped = false


func _on_ShootSpread_shot(bullet):
	if not _broken:
		return
	bullet.set_kill_time(rand_range(lifetime.x, lifetime.y))
