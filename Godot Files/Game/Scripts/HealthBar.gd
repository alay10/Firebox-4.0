extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var maxWidth = 150
var realWidth = 150

export (ShaderMaterial) var shader
#export var color = Color(0,0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	#var headBandColor = shader.get_shader_param("headBand")
	#var healthBarColor = Vector3(headBandColor.r, headBandColor.b, headBandColor.g)
	$ColorRect.color = shader.get_shader_param("headBand")
	pass # Replace with function body.

func updateHealthBar(var percent: float):
	
	print("health percent:" + String(percent))
	realWidth = maxWidth * percent
	$ColorRect.rect_size = Vector2(realWidth, 20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
