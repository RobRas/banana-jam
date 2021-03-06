extends Node2D

export(PackedScene) var bullet_scene
export(float) var bullet_speed
var gatling_sound_playing=false

signal shot(bullet)


func init(player):
	for child in get_children():
		if child.has_method("init"):
			child.init(player)
	unequip()


func equip():
	for child in get_children():
		if child.has_method("equip"):
			child.equip()

func unequip():
	for child in get_children():
		if child.has_method("unequip"):
			child.unequip()

func break_random():
	if has_node("Breaks"):
		return $Breaks.break_random()

func is_fully_broken():
	if not has_node("Breaks"):
		return true
	return $Breaks.is_fully_broken()

func _on_shot(bullet):
	emit_signal("shot", bullet)
	if $GunSound.playing==false:
		$GunSound.play()
		
	
	
