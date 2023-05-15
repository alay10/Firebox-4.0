extends Control

var can_change_key = false
var action_string
enum Players {P1, P2}
enum ACTIONS {move_left, move_right, _Down, _Jump, _Attack}

# Called when the node enters the scene tree for the first time.
func _ready():
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
	_mark_button("P1move_left")

func b_change_key_P1move_right():
	_mark_button("P1move_right")

func b_change_key_P1_Down():
	_mark_button("P1_Down")

func b_change_key_P1_Jump():
	_mark_button("P1_Jump")
	
func b_change_key_P1_Attack():
	_mark_button("P1_Attack")
	
func b_change_key_P2move_left():
	_mark_button("P2move_left")

func b_change_key_P2move_right():
	_mark_button("P2move_right")

func b_change_key_P2_Down():
	_mark_button("P2_Down")

func b_change_key_P2_Jump():
	_mark_button("P2_Jump")
	
func b_change_key_P2_Attack():
	_mark_button("P2_Attack")
	
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
