extends Node2D

export(PackedScene) var bullet_scene
export(float) var bullet_speed

signal shot(bullet)


func _ready():
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("shot", world, "_on_player_shot")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var bullet = bullet_scene.instance()
	var bullet_velocity = (get_global_mouse_position() - global_position) * bullet_speed
	emit_signal("shot", bullet)
	bullet.init(global_position, bullet_velocity)
