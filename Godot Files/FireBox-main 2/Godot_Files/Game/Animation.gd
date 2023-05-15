extends AnimatedSprite2D

var action
var other

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().name == "P1":
		other = "P2"
	else:
		other = "P1"

	set_frame(0)
	pass # Replace with function body.

func _process(delta):

	if get_parent().get_position().x < get_parent().get_parent().get_node(str(other)).get_position().x:
		action = "move_right"
	else:
		action = "move_left"
	
	if Input.is_action_pressed(get_parent().name + str(action)):
		set_frame(1)
	else:
		set_frame(0)
