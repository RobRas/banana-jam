extends KinematicBody2D

signal hit(body)

export(int) var damage = 1
export(float) var kill_time

var _velocity = Vector2()


func _ready():
	$KillTimer.wait_time = kill_time
	$KillTimer.start()

func init(position, velocity):
	self.position = position
	_velocity = velocity

func _physics_process(_delta):
	_velocity = move_and_slide(_velocity)

func _on_KillTimer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("bullet_hit"):
		body.bullet_hit(damage)
	emit_signal("hit", body)
