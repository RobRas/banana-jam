extends Node2D


func _on_player_shot(bullet):
	var current_position = bullet.position
	$Bullets.add_child(bullet)
	bullet.position = current_position
