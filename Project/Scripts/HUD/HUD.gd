extends Control

export(PackedScene) var break_label


func _on_Player_part_broken(part_name):
	var label_scene = break_label.instance()
	label_scene.text = part_name
	$BreaksContainer/Breaks.add_child(label_scene)
