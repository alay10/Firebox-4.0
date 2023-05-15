extends Node2D

var Displaytime = 0

@onready var timer = get_node("Timer");

func _ready():
	timer.set_wait_time(1);
	timer.start(0);

func _on_Timer_timeout():
	Displaytime += 1;
