extends KinematicBody2D

signal hit(body)

export(SpriteFrames) var sprite_frames
export(int) var damage = 1
export(float) var kill_time

var _velocity = Vector2()


func _ready():
	$Sprite.frames = sprite_frames
	$KillTimer.wait_time = kill_time
	$KillTimer.start()

func init(position, rotation, velocity):
	global_position = position
	global_rotation = rotation
	_velocity = velocity

func set_kill_time(new_kill_time):
	$KillTimer.wait_time = new_kill_time
	$KillTimer.start()

func _physics_process(delta):
	var collision = move_and_collide(_velocity * delta)
	if collision:
		_velocity = collision.normal * _velocity.length()
		global_rotation = Vector2(1,0).angle_to(collision.normal)

func _on_KillTimer_timeout():
	queue_free()

func set_enemy_bounce():
	set_collision_mask_bit(2, true)

func _on_Area2D_body_entered(body):
	if body.has_method("bullet_hit"):
		body.bullet_hit(damage)
	emit_signal("hit", body)
