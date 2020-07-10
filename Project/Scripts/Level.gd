extends Node2D

export (PackedScene) var Baddie
var hit_count;

func _on_player_shot(bullet):
	var current_position = bullet.position
	add_child(bullet)
	bullet.position = current_position


func _on_Player_hit():
	hit_count += 1

func _on_BaddieSpawnTimer_timeout():
	var baddie = Baddie.instance()
	add_child(baddie)
	baddie.position
