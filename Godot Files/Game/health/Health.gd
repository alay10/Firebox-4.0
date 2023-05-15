extends Node

signal max_changed(new_max)
signal changed(new_health)
signal end_game
@export (int) var max_health = 10: set = set_max

@onready var current = max_health: set = set_current

func _read():
	_initialze();
	
func set_max(new_max):
	max_health = new_max;
	max_health = max(1, new_max);
	emit_signal("max_changed", max_health);
		
func set_current(new_value):
	current = new_value;
	current = clamp(current, 0, max_health);
	emit_signal("changed", current);
	
	if current == 0:
		emit_signal("end_game")
		

func _initialze():
	emit_signal("max_changed", max_health);
	emit_signal("changed", current);
	
func readhit():
	set_current(current - 1)
	
