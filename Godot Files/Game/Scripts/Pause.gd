extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _pressed():
	print("Button Pressed Main Menu")
	var new_state = !get_tree().paused
	get_tree().paused = new_state
	get_parent().get_parent().get_node("Pause_CanvasLayer").get_node("Pause").visible = new_state
	#get_tree().change_scene("res://MainMenu/Main Menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
