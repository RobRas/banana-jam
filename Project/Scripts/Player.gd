extends KinematicBody2D

signal hit

export(int) var speed = 200
var velocity = Vector2()

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("move_down"):
		velocity += Vector2(0, speed)
	if Input.is_action_pressed("move_up"):
		velocity -= Vector2(0, speed)
	if Input.is_action_pressed("move_left"):
		velocity -= Vector2(speed, 0)
	if Input.is_action_pressed("move_right"):
		velocity += Vector2(speed, 0)
	if velocity.length()>0:
		$RocketBooster.stream_paused=false
		$Sprite.play("Boosting")
	else:
		$RocketBooster.stream_paused=true
		$Sprite.play("Idle")

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	emit_signal("hit")
