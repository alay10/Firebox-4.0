extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var secondsElapsed = get_parent().Displaytime
	var seconds = secondsElapsed
	#var minute = seconds / 60;
	#var second = seconds % 60;
	#var Displaystr = "%02d:%02d" % [minute, second];
	
	var Displaystr = "%d" % [100-seconds]
	text = Displaystr;
	
	if (seconds == 100):
		get_tree().change_scene("res://MainMenu/Main Menu.tscn")
