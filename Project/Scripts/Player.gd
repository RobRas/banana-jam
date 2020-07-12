extends KinematicBody2D

signal hit
signal part_broken(part_name)

var velocity = Vector2()
var additional_velocity = Vector2()
var forward

func _ready():
	forward = $Forward
	for ability in $Abilities.get_children():
		ability.init(self)

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
	move_and_slide(velocity + additional_velocity)


func _on_Area2D_body_entered(body):
	emit_signal("hit")


func _on_Break_body_entered(body):
	break_part()

func break_part():
	print("Break_body_entered")
	var part_name = $Abilities.break_random()
	emit_signal("part_broken", part_name)
