extends Node2D

export(int) var min_speed = 40
export(int) var max_speed = 90
signal enemy_hit(pos)

var run_speed = rand_range(min_speed, max_speed)
var dv
var player

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	
func _physics_process(_delta):
	
	if player:
		dv = get_parent().position.direction_to(player.position) * run_speed
	get_parent().velocity = dv
