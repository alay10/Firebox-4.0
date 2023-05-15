extends Control

@export (ShaderMaterial) var P1_Shader
@export (ShaderMaterial) var P2_Shader


func _ready():
	
	# Tie our colors to the globals
	$Column/Colors/P1_Select/P1_Head_Color.color = Global.p2_headband_color
	$Column/Colors/P1_Select/P1_Body_Color.color = Global.p2_body_color
	$Column/Colors/P2_Select/P2_Head_Color.color = Global.p1_headband_color
	$Column/Colors/P2_Select/P2_Body_Color.color = Global.p1_body_color
	pass

func _process(delta):
	
	# Update Shader
	P1_Shader.set_shader_parameter("headBand", Global.p1_headband_color)
	P1_Shader.set_shader_parameter("body", Global.p1_body_color)
	P2_Shader.set_shader_parameter("headBand", Global.p2_headband_color)
	P2_Shader.set_shader_parameter("body", Global.p2_body_color)
	pass
		

# Change Global when color is changed
func _on_P1_Head_Color_color_changed(color):
	Global.p2_headband_color = color


func _on_P1_Body_Color_color_changed(color):
	Global.p2_body_color = color
	

func _on_P2_Head_Color_color_changed(color):
	Global.p1_headband_color = color
	pass # Replace with function body.


func _on_P2_Body_Color_color_changed(color):
	Global.p1_body_color = color
	pass # Replace with function body.

# Start game
func _on_Start_pressed():
	get_tree().change_scene_to_file("res://Game/GameState_KinematicBodyRework.tscn")
