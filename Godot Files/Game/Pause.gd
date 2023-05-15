# This is not for pause buttopn
# This work as CanvasLayer right now
extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Pause Menu").get_node("HSlider").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	#print("Set volume", AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var new_state = !get_tree().paused
		get_tree().paused = new_state
		visible = new_state

func _on_Continue_Button_pressed():
	print("Continue Button Pressed")
	var new_state = !get_tree().paused
	get_tree().paused = new_state
	visible = new_state

func _on_Return_main_pressed():
	# continue for everything then return to main menu
	print("Button Pressed Main Menu")
	var new_state = !get_tree().paused
	get_tree().paused = new_state
	visible = new_state
	get_tree().change_scene("res://MainMenu/Main Menu.tscn")



func _on_HSlider_value_changed(value):
	MusicControl.set_master(value)
