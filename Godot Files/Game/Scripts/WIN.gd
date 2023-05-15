extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	#var t = _HealthBar"
	
	# Ensure no tints
	$Winner.get_material().set_shader_param("customColor", false)
	$Loser.get_material().set_shader_param("customColor", false)
	$Winner.get_material().set_shader_param("shading", false)
	$Loser.get_material().set_shader_param("shading", false)
	# Assign player colors to the winner and losers appropriately
	if (Global.win_player == "P2"):
		
		$Winner.get_material().set_shader_param("headBand", Global.p1_headband_color)
		$Winner.get_material().set_shader_param("body", Global.p1_body_color) 
		$Loser.get_material().set_shader_param("headBand", Global.p2_headband_color)
		$Loser.get_material().set_shader_param("body", Global.p2_body_color) 
	elif (Global.win_player == "P1"):
		$Winner.get_material().set_shader_param("headBand", Global.p2_headband_color)
		$Winner.get_material().set_shader_param("body", Global.p2_body_color) 
		$Loser.get_material().set_shader_param("headBand", Global.p1_headband_color)
		$Loser.get_material().set_shader_param("body", Global.p1_body_color) 
	
	# If its a tie then make both of them invisible
	else:
		$Winner.visible = false
		$Loser.visible = false
		
	
	get_node("Win_info").text = Global.win_player + " WINS!"
	
	
func _on_Button_button_down():
	get_tree().change_scene("res://Game/GameState_KinematicBodyRework.tscn")


func _on_Button2_button_down():
	get_tree().change_scene("res://MainMenu/Main Menu.tscn")
