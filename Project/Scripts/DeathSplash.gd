extends Control


func _ready():
	$SelfDestruct.play()

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene("res://Scenes/Level.tscn")
