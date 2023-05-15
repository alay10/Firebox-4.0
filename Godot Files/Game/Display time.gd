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
		
		# Timeout now goes to highest health player
		if (Global.p1_Health > Global.p2_Health):
			Global.win_player = "P2"
			get_tree().change_scene_to_file("res://Game/WIN.tscn")
		elif (Global.p2_Health > Global.p1_Health):
			Global.win_player = "P1"
			get_tree().change_scene_to_file("res://Game/WIN.tscn")
		# Pray this never happens
		else:
			Global.win_player = "Nobody"
			get_tree().change_scene_to_file("res://Game/WIN.tscn")
