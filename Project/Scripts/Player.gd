extends KinematicBody2D

export(int) var max_heat = 10
export(int) var max_scrap = 10
export(float) var invulnerability_time = 5.0
export(int) var breaks_to_die = 3
var _current_breaks = 0
var critical_sound_playing
var normal_music_playing

signal damaged(damage)
signal overheated()
signal part_broken(break_node)
signal scrap_gained(amount, total)
signal part_repaired(break_node)
signal blown_up
signal critical_status
signal critical_repaired

var velocity = Vector2()
var additional_velocity = Vector2()
var forward
var heat = 0

var scrap_value = 0
var _invulnerable = false

func _ready():
	$InvulnTimer.wait_time = invulnerability_time
	critical_sound_playing=false
	normal_music_playing=true
	var world = get_tree().get_nodes_in_group("World")[0]
	connect("critical_status", world, "_on_critical_status")
	connect("critical_repaired", world, "_on_critical_repair")
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
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.collision_layer == 32: # Is environment
			if velocity.dot(collision.normal) > 0:
				var ang = Vector2(1, 0).angle_to(collision.normal)
				var to_remove = velocity.rotated(ang)
				velocity -= Vector2(to_remove.x, 0)

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
	print(_current_breaks)
	if _current_breaks >= breaks_to_die-1 and critical_sound_playing==false:
		emit_signal("critical_status")
		critical_sound_playing=true
		normal_music_playing=false
	if _current_breaks >= breaks_to_die:
		print("boom.")
		emit_signal("blown_up")
		queue_free()
		return

	var break_node = $Abilities.break_random()
	emit_signal("part_broken", break_node)
	$BrokenEqSound.play()

# Try to do the opposite of breakage
func unbreak_part():
	max_scrap += 1
	if _current_breaks <= 0:
		return
	_current_breaks -= 1
	var break_node = $Abilities.unbreak_part()
	emit_signal("part_repaired", break_node)
	$RepairSound.play()
	if _current_breaks < breaks_to_die-1 and critical_sound_playing==true:
		critical_sound_playing=false
		normal_music_playing=true
		emit_signal("critical_repaired")

func _on_Area2D_area_entered(area):
	if area.get_parent().get_script().get_path().get_file() == "RepairDrop":
		emit_signal("scrap_gained", area.value_repaired)

func _set_invulnerable():
	if _invulnerable:
		return
	_invulnerable = true
	$InvulnTimer.start()
	$Sprite.modulate=Color(0.05,0.37,1,1)


func _on_InvulnTimer_timeout():
	_invulnerable = false
	$Sprite.modulate=Color(1,1,1,1)

func get_max_speed():
	return $Abilities/Movement.max_speed

func set_max_speed(new_value):
	$Abilities/Movement.max_speed = new_value
