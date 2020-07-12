extends Control

export(PackedScene) var break_label


func _on_Player_part_broken(part_name):
	var label_scene = break_label.instance()
	label_scene.text = part_name
	$BreaksContainer/Breaks.add_child(label_scene)


func _on_Player_scrap_gained(amount, total_value):
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.value = total_value
