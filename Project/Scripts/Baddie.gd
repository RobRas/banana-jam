extends KinematicBody2D

export(int) var min_speed = 150
export(int) var max_speed = 250

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


func _on_Area2D_body_entered(body):
	queue_free()
