extends Node2D

export (PackedScene) var Baddie
export (PackedScene) var GooExplosion
export (PackedScene) var ShotgunSmoke
var hit_count;
var rand = RandomNumberGenerator.new()

func _on_player_shot(bullet):
	var current_position = bullet.position
	$Bullets.add_child(bullet)
	bullet.position = current_position
	
#func _on_Player_hit():
#	hit_count += 1

func _on_enemy_hit(pos):
	var explode = GooExplosion.instance()
	add_child(explode)
	explode.position=pos
	explode.one_shot=true
	explode.emitting=true
	

func _on_BaddieSpawnTimer_timeout():
	var baddie = Baddie.instance()
	add_child(baddie)
	baddie.connect("enemy_hit",self,"_on_enemy_hit")
	
	# Not sure if this spawns enemies on screen, or just within a
	# screen of the player
	var screen_size = get_viewport().get_visible_rect().size
	rand.randomize()
	var x = rand.randf_range(0,screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0,screen_size.y)
	baddie.position.x = x
	baddie.position.y = y
	
	# Pass player to Baddie to they can home in
	baddie.player = $Player
	
func _shotgun_smoke():
	var smoke =ShotgunSmoke.instance()
	add_child(smoke)
	smoke.position=$Player.position
	smoke.set_rotation($Player.get_rotation())
	smoke.emitting=true
	smoke.one_shot=true
	
