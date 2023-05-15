extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxWidth = 150
var realWidth = 150

@export var color = Color(0,0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = color
	pass # Replace with function body.

func updateHealthBar(percent: float):
	
	realWidth = maxWidth * percent
	$ColorRect.size = Vector2(realWidth, 20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
