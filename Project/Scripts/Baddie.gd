extends KinematicBody2D

var velocity = Vector2.ZERO

func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	
#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free() # Remove if it leaves screen somehow
