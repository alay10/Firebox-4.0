extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var stop_music = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start.grab_focus()
	
	MusicControl._paly_basic_music()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#get_tree().change_scene("res://Game/GameState.tscn")
	pass # Replace with function body.

#func _on_Quit_pressed():
#	get_tree().quit()


func _on_Options_pressed():
	get_tree().change_scene_to_file("res://Options/Options.tscn")
