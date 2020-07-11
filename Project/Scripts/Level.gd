extends Node2D

export (PackedScene) var Homer
export (PackedScene) var Flanker
var hit_count;
var rand = RandomNumberGenerator.new()

func _on_player_shot(bullet):
	var current_position = bullet.position
	$Bullets.add_child(bullet)
	bullet.position = current_position


#func _on_Player_hit():
#	hit_count += 1

func _on_enemy_hit(pos):
	$Explosion.position=pos
	#$Explosion.one_shot=true
	$Explosion.emitting=true
	

func _on_HomerSpawnTimer_timeout():
	var homer = Homer.instance()
	add_child(homer)
	homer.connect("enemy_hit",self,"_on_enemy_hit")
	
	# Not sure if this spawns enemies on screen, or just within a
	# screen of the player
	var screen_size = get_viewport().get_visible_rect().size
	rand.randomize()
	var x = rand.randf_range(0,screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0,screen_size.y)
	homer.position.x = x
	homer.position.y = y


func _on_FlankerSpawnTimer_timeout():
	var flanker = Flanker.instance()
	add_child(flanker)
	flanker.connect("enemy_hit",self,"_on_enemy_hit")
	
	# Not sure if this spawns enemies on screen, or just within a
	# screen of the player
	var screen_size = get_viewport().get_visible_rect().size
	rand.randomize()
	var x = rand.randf_range(0,screen_size.x)
	rand.randomize()
	var y = rand.randf_range(0,screen_size.y)
	flanker.position.x = x
	flanker.position.y = y
