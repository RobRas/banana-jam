extends Control


func init(break_name, description):
	$VBoxContainer/MarginContainer/DescriptionLabel.text = description
	$VBoxContainer/NameLabel.text = break_name
