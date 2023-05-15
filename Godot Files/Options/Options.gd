extends Control

var can_change_key = false
var action_string
enum Players {P1, P2}
enum ACTIONS {move_left, move_right, _Down, _Jump, _Attack}

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Panel/Master").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	get_node("Panel/Music").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	get_node("Panel/SFX").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	get_node("Panel/language").text = Global.language
	_set_keys()

func _set_keys():
	for i in Players:
		for j in ACTIONS:
			get_node("Panel/ScrollContainer" + str(i) + "/VBoxContainer" + str(i) + "/HBoxCont_" + str(i) + str(j) + "/Button").set_pressed(false)
			if !InputMap.get_action_list(str(i) + str(j)).empty():
				get_node("Panel/ScrollContainer" + str(i) + "/VBoxContainer" + str(i) + "/HBoxCont_" + str(i) + str(j) + "/Button").set_text(InputMap.get_action_list(str(i) + str(j))[0].as_text())
			else:
				get_node("Panel/ScrollContainer" + str(i) + "/VBoxContainer" + str(i) + "/HBoxCont_" + str(i) + str(j) + "/Button").set_text("No Button!")


func b_change_key_P1move_left():
	_mark_button("P2move_left")

func b_change_key_P1move_right():
	_mark_button("P2move_right")

func b_change_key_P1_Down():
	_mark_button("P2_Down")

func b_change_key_P1_Jump():
	_mark_button("P2_Jump")
	
func b_change_key_P1_Attack():
	_mark_button("P2_Attack")
	
func b_change_key_P2move_left():
	_mark_button("P1move_left")

func b_change_key_P2move_right():
	_mark_button("P1move_right")

func b_change_key_P2_Down():
	_mark_button("P1_Down")

func b_change_key_P2_Jump():
	_mark_button("P1_Jump")
	
func b_change_key_P2_Attack():
	_mark_button("P1_Attack")
	
func _mark_button(string):
	can_change_key = true
	action_string = string
	
	for i in Players:
		for j in ACTIONS:
			if (str(i) + str(j)) != string:
				get_node("Panel/ScrollContainer" + str(i) + "/VBoxContainer" + str(i) + "/HBoxCont_" + str(i) + str(j) + "/Button").set_pressed(false)


func _input(event):
	if event is InputEventKey: 
		if can_change_key:
			_change_key(event)
			can_change_key = false

func _change_key(new_key):
	#Delete key of pressed button
	if !InputMap.get_action_list(action_string).empty():
		InputMap.action_erase_event(action_string, InputMap.get_action_list(action_string)[0])
	
	#Check if new key was assigned somewhere
	for i in ACTIONS:
		if InputMap.action_has_event(i, new_key):
			InputMap.action_erase_event(i, new_key)
			
	#Add new Key
	InputMap.action_add_event(action_string, new_key)
	
	_set_keys()


func _on_main_menu_pressed():
	get_tree().change_scene("res://MainMenu/Main Menu.tscn")

func _on_Master_value_changed(value):
	MusicControl.set_master(value)

func _on_Music_value_changed(value):
	MusicControl.set_music(value)

func _on_SFX_value_changed(value):
	MusicControl.set_sfx(value)



func _on_language_pressed():
	get_node("Panel/language/VBoxContainer").visible = true;
	get_node("Panel/language/VBoxContainer").add_constant_override("separation", 0)

func _on_en_pressed():
	get_node("Panel/language/VBoxContainer").visible = false;
	get_node("Panel/language").text = "ENGLISH"
	Global.language = "ENGLISH"
	TranslationServer.set_locale('en')
	
func _on_es_pressed():
	get_node("Panel/language/VBoxContainer").visible = false;
	get_node("Panel/language").text = "ESPAÑOL"
	Global.language = "ESPAÑOL"
	TranslationServer.set_locale('es')

func _on_fr_pressed():
	get_node("Panel/language/VBoxContainer").visible = false;
	get_node("Panel/language").text = "Français"
	Global.language = "Français"
	TranslationServer.set_locale('fr')
