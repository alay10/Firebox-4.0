extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	pass # Replace with function body.


func _process(delta):
	if Input.is_key_pressed(KEY_LEFT):
		self.visible = true
	else:
		self.visible = false
