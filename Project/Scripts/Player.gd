extends KinematicBody2D

signal hit

var velocity = Vector2()

func _ready():
	for ability in $Abilities.get_children():
		ability.init(self)
	$Shotgun.init(self)

func _process(delta):
	if velocity.length()>0:
		$RocketBooster.stream_paused=false
		$Sprite.play("Boosting")
		$Booster1.emitting=true
		$Booster2.emitting=true
	else:
		$RocketBooster.stream_paused=true
		$Sprite.play("Idle")
		$Booster1.emitting=false
		$Booster2.emitting=false

func _physics_process(_delta):
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	emit_signal("hit")
