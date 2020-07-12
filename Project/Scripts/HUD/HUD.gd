extends Control

export(PackedScene) var break_label


func _ready():
	var player = get_tree().get_nodes_in_group("players")[0]
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.max_value = player.max_heat
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.max_value = player.max_scrap

func _on_Player_part_broken(part_name):
	var label_scene = break_label.instance()
	label_scene.text = part_name
	$BreaksContainer/Breaks.add_child(label_scene)


func _on_Player_scrap_gained(amount, total_value):
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.value = total_value


func _on_Player_damaged(amout, total_heat):
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.value = total_heat


func _on_Player_overheated():
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.value = 0
