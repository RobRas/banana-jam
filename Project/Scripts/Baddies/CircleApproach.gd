extends Node

export(int) var min_speed = 250
export(int) var max_speed = 400
export(float) var approach_delta = 0.4
signal enemy_hit(pos)

var run_speed = rand_range(min_speed, max_speed)
var dv
var player
var tangent = Vector2.ZERO
var reverse = false
var rand = RandomNumberGenerator.new()

func _ready():
	player = get_tree().get_nodes_in_group("players")[0]
	rand.randomize()
	if rand.randi_range(0,1) == 1:
		reverse = true
	
func _physics_process(_delta):
	
	if player:
		tangent = get_parent().global_position.direction_to(player.global_position).tangent()
		if (reverse):
			tangent = tangent.reflect(get_parent().global_position.direction_to(player.global_position))
		dv = tangent.move_toward(get_parent().global_position.direction_to(player.global_position), approach_delta)
		dv *= run_speed
	get_parent().velocity = dv
