extends Control

export(PackedScene) var break_label


func _ready():
	var player = get_tree().get_nodes_in_group("players")[0]
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.max_value = player.max_heat
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.max_value = player.max_scrap

func _on_Player_part_broken(break_node):
	var label_scene = break_label.instance()
	label_scene.init(break_node.break_name, break_node.break_description)
	$BreaksContainer/Breaks.add_child(label_scene)


func _on_Player_scrap_gained(amount, total_value):
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.value = total_value


func _on_Player_damaged(amout, total_heat):
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.value = total_heat


func _on_Player_overheated():
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.value = 0


func _on_Player_part_repaired(part_name):
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.value = 0
	$StatsContainer/Stats/ScrapModule/CenterContainer/ScrapBar.max_value = get_tree().get_nodes_in_group("players")[0].max_scrap
	var node_to_delete = $BreaksContainer/Breaks.get_child(0)
	$BreaksContainer/Breaks.remove_child(node_to_delete)
	node_to_delete.queue_free()


func _on_Player_critical_status():
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.set_danger(true)


func _on_Player_critical_repaired():
	$StatsContainer/Stats/Heat_Module/CenterContainer/HeatBar.set_danger(false)
