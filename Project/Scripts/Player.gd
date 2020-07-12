extends KinematicBody2D

export(float) var invulnerability_time = 3.0

signal damaged(damage)
signal part_broken(part_name)
signal scrap_gained(amount, total)

var velocity = Vector2()
var additional_velocity = Vector2()
var forward
export(int) var health = 10

var scrap_value = 0
var _invulnerable = false

func _ready():
	$InvulnTimer.wait_time = invulnerability_time
	
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

func _on_player_heal(amount_healed):
	health += amount_healed
	print(health)

func _on_Break_body_entered(body):
	print(body.name)

func bullet_hit(damage):
	if _invulnerable:
		return
	emit_signal("damaged")
	break_part()
	_set_invulnerable()

func scrap_hit(scrap, value):
	print("Scrap")
	scrap_value += value
	emit_signal("scrap_gained", value, scrap_value)
	scrap.destroy()
	
	if scrap_value >= 5:
		scrap_value = 0
		unbreak_part()
	

func break_part():
	print("Break_body_entered")
	var part_name = $Abilities.break_random()
	emit_signal("part_broken", part_name)

# Try to do the opposite of breakage
func unbreak_part():
	print("Player: Unbreak_part()")
	var part_name = $Abilities.unbreak_part()

func _on_Area2D_area_entered(area):
	if area.get_parent().get_script().get_path().get_file() == "RepairDrop":
		print("Scrap")
		emit_signal("scrap_gained", area.value_repaired)

func _set_invulnerable():
	if _invulnerable:
		return
	_invulnerable = true
	$InvulnTimer.start()


func _on_InvulnTimer_timeout():
	_invulnerable = false
