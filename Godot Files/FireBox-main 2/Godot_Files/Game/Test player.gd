extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fspeed = 5
var bspeed = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		self.position.x-= 1 * fspeed
	if Input.is_key_pressed(KEY_RIGHT):
		self.position.x+= 1 * bspeed
