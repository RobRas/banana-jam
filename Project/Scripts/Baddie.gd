extends KinematicBody2D

export(int) var min_speed = 40
export(int) var max_speed = 90
signal enemy_hit(pos)

var _run_speed = rand_range(min_speed, max_speed)
var _velocity = Vector2.ZERO
var player = null

func _physics_process(_delta):
	_velocity - Vector2.ZERO
	if player:
		_velocity = position.direction_to(player.position) * _run_speed
	_velocity = move_and_slide(_velocity)

#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free() # Remove if it leaves screen somehow

func _on_Area2D_area_entered(area):
	emit_signal("enemy_hit",$Sprite.global_position)
	queue_free()
