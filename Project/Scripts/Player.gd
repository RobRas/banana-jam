extends KinematicBody2D

signal hit

var velocity = Vector2()
var additional_velocity = Vector2()
var forward
export(int) var health = 10

func _ready():
	forward = $Forward
	for ability in $Abilities.get_children():
		ability.init(self)
	
	# Listen for repair pickup repairing from Level
	get_tree().get_nodes_in_group("World")[0].connect("player_heal", self, "_on_player_heal")

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

func _on_player_heal(amount_healed):
	health += amount_healed
	print(health)

func _on_Break_body_entered(body):
	$Abilities.break_random()
