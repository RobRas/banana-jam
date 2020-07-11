extends Node

export(int) var min_speed = 40
export(int) var max_speed = 90
export(float) var approach_delta = 0.6
signal enemy_hit(pos)

var run_speed = rand_range(min_speed, max_speed)
var dv
var player
var tangent = Vector2.ZERO

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	
func _physics_process(_delta):
	
	if player:
		tangent = get_parent().global_position.direction_to(player.global_position).tangent()
		dv = tangent.move_toward(get_parent().global_position.direction_to(player.global_position), approach_delta)
		dv *= run_speed
	get_parent().velocity = dv
