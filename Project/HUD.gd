extends Node

onready var heat_track = $GUI/States/Alerts/Quadrant/Heat_Module/TextureProgress
onready var scrap_track = $GUI/States/Alerts/Quadrant/Scrap_Module/TextureProgress

onready var tween = $Tween

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var current_heat = $"../Characters/Player" .heat_state
	var current_scrap =$"../Characters/Player" .scrap_state
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
