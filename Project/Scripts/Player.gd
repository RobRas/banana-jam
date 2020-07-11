extends KinematicBody2D

signal hit

var velocity = Vector2()

func _ready():
	for ability in $Abilities.get_children():
		ability.init(self)
	$Shotgun.init(self)

func _physics_process(_delta):
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	emit_signal("hit")
