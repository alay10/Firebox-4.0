extends TextureRect

@export var move = KEY_LEFT

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("%smove_left" % get_parent().name):
		self.visible = true
	else:
		self.visible = false
