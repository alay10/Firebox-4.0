extends Node2D

var Displaytime = 0

onready var timer = get_node("Timer");
#var red = load("res://Game/materials/p1Shader.tres")ff8282
#var blue = load("res://Game/materials/p2Shader.tres")#6db9de

func _ready():
	#if Global.p1_color == "red" :
		#get_parent().get_node("P1/PlayerSprite").material = red
		#get_node("P1_HealthBar/ColorRect").color = red.get_shader_param("headBand")
		#get_parent().get_node("P1/fireballAnim/ColorRect").color = red.get_shader_param("headBand")
		
	#elif Global.p1_color == "blue" :
		#get_parent().get_node("P1/PlayerSprite").material = blue
		#get_node("P1_HealthBar/ColorRect").color = blue.get_shader_param("headBand")
		#get_parent().get_node("P1/fireballAnim/ColorRect").color = blue.get_shader_param("headBand")
		
	#if Global.p2_color == "red" :
		#get_parent().get_node("P2/PlayerSprite").material = red
		#get_node("P2_HealthBar/ColorRect").color = red.get_shader_param("headBand")
		#get_parent().get_node("P2/fireballAnim/ColorRect").color = red.get_shader_param("headBand")
	#elif Global.p2_color == "blue" :
		#get_parent().get_node("P2/PlayerSprite").material = blue
		#get_node("P2_HealthBar/ColorRect").color = blue.get_shader_param("headBand")
		#get_parent().get_node("P2/fireballAnim/ColorRect").color = blue.get_shader_param("headBand")
		
	timer.set_wait_time(1);
	timer.start(0);

func _on_Timer_timeout():
	Displaytime += 1;
