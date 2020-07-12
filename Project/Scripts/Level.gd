extends Node2D

export (PackedScene) var Baddie
export (PackedScene) var GooExplosion
export (PackedScene) var ShotgunSmoke
export (PackedScene) var GatlingSmoke
export (PackedScene) var Homer
export (PackedScene) var Flanker
export (PackedScene) var RepairDrop
export (PackedScene) var GameOverScene

signal player_heal

var hit_count;
var rand = RandomNumberGenerator.new()
var shotgun_smoke_velocity=300.0
var gatling_smoke_velocity=300.0
const PARAM_INITIAL_LINEAR_VELOCITY=0
const PARAM_ANGLE = 7

func _on_player_shot(bullet):
	$Bullets.add_child(bullet)
	
#func _on_Player_hit():
#	hit_count += 1

func _on_enemy_hit(pos):
	var explode = GooExplosion.instance()
	add_child(explode)
	explode.position=pos
	explode.one_shot=true
	explode.emitting=true
	

func _on_HomerSpawnTimer_timeout():
	var homer = Homer.instance()
	add_child(homer)
	homer.connect("Baddie_dead",self,"_on_Baddie_dead")
	
	rand.randomize()
	var x = rand.randf_range(-1500,1500)
	rand.randomize()
	var y = rand.randf_range(-900,900)
	homer.position.x = x
	homer.position.y = y

func _on_FlankerSpawnTimer_timeout():
	var flanker = Flanker.instance()
	add_child(flanker)
	flanker.connect("Baddie_dead",self,"_on_Baddie_dead")
	
	rand.randomize()
	var x = rand.randf_range(-1500,1500)
	rand.randomize()
	var y = rand.randf_range(-900,900)
	flanker.position.x = x
	flanker.position.y = y
	
func _shotgun_smoke():
	var smoke = ShotgunSmoke.instance()
	add_child(smoke)
	smoke.position=$Player.position
	smoke.set_rotation($Player.get_rotation())
	smoke.emitting=true
	smoke.one_shot=true

func _gatling_smoke():
	var gsmoke = GatlingSmoke.instance()
	add_child(gsmoke)
	gsmoke.position=$Player.position
	gsmoke.set_rotation($Player.get_rotation())
	gsmoke.emitting=true
	gsmoke.one_shot=true
	
	

# Emitted in Baddie>#HitsToDie node
func _on_Baddie_dead(drop_value, drop_position):
	var repair_drop = RepairDrop.instance()
	add_child(repair_drop)
	repair_drop.init(drop_value, drop_position)


func _on_Player_blown_up():
	get_tree().change_scene("res://Scenes/Death Splash.tscn")

func _on_critical_status():
	$MainTheme.stop()
	$CriticalOverHeat.play()
