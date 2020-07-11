extends KinematicBody2D


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

func _on_Area2D_area_entered(area):
	queue_free()
