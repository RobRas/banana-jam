extends KinematicBody2D

var velocity = Vector2.ZERO
signal enemy_hit
func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	
#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free() # Remove if it leaves screen somehow


func _on_Area2D_area_entered(area):
	emit_signal("enemy_hit",global_position)
