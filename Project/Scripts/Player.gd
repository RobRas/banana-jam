extends KinematicBody2D


export(int) var speed = 200

var velocity = Vector2()

func _ready():
	$Abilities/FaceMouse.init(self)
	$Shotgun.init(self)

func get_input():
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
