extends KinematicBody2D

export(NodePath) var damage_node_path
var _damage_node

var velocity = Vector2.ZERO

signal Baddie_dead
var dead = false


func _ready():
	_damage_node = get_node(damage_node_path)

func _physics_process(_delta):
	velocity = move_and_slide(velocity)

func _on_Baddie_dead(drop_value, drop_position):
	if not dead:
		emit_signal("Baddie_dead", drop_value, drop_position)
		dead = true

func bullet_hit(damage):
	_damage_node.damage(damage)
