extends KinematicBody2D


var _velocity = Vector2()

func init(position, velocity):
	self.position = position
	_velocity = velocity

func _physics_process(_delta):
	_velocity = move_and_slide(_velocity)
