extends KinematicBody2D

export(int) var max_heat = 10
export(int) var max_scrap = 10
export(float) var invulnerability_time = 5.0
export(int) var breaks_to_die = 8
var _current_breaks = 0

signal damaged(damage)
signal overheated()
signal part_broken(part_name)
signal scrap_gained(amount, total)
signal part_repaired(part_name)
signal blown_up

var velocity = Vector2()
var additional_velocity = Vector2()
var forward
var heat = 0

var scrap_value = 0
var _invulnerable = false

func _ready():
	$InvulnTimer.wait_time = invulnerability_time
	
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

func bullet_hit(damage):
	if _invulnerable:
		return
	
	heat += damage
	emit_signal("damaged", damage, heat)
	
	if heat >= max_heat:
		heat = 0
		emit_signal("overheated")
		break_part()
		_set_invulnerable()

func scrap_hit(scrap, value):
	scrap_value += value
	emit_signal("scrap_gained", value, scrap_value)
	scrap.destroy()
	
	if scrap_value >= max_scrap:
		scrap_value = 0
		unbreak_part()
	

func break_part():
	_current_breaks += 1
	if _current_breaks >= breaks_to_die:
		print("boom.")
		emit_signal("blown_up")
		queue_free()
		return
		
	var part_name = $Abilities.break_random()
	emit_signal("part_broken", part_name)
	$BrokenEqSound.play()

# Try to do the opposite of breakage
func unbreak_part():
	if _current_breaks <= 0:
		return
	_current_breaks -= 1
	var part_name = $Abilities.unbreak_part()
	emit_signal("part_repaired", part_name)
	$RepairSound.play()

func _on_Area2D_area_entered(area):
	if area.get_parent().get_script().get_path().get_file() == "RepairDrop":
		emit_signal("scrap_gained", area.value_repaired)

func _set_invulnerable():
	if _invulnerable:
		return
	_invulnerable = true
	$InvulnTimer.start()


func _on_InvulnTimer_timeout():
	_invulnerable = false
