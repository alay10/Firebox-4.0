extends Node2D
class_name Player_cont

var move = load("res://Game/Move/move.tscn")

func _read_input():
	if Input.is_action_just_pressed("move_right"): move.exicute(self, "right")
	if Input.is_action_just_pressed("move_left"): move.exicute(self, "left")
