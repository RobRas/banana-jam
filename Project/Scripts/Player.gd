extends KinematicBody2D


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

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
