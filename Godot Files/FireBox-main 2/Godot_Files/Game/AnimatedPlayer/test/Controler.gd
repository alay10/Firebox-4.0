extends Node2D
class_name cont

var left_move = 65
var right_move = 68
var controler = 0

func _get_left(player):
	if player == "P1":
		left_move = 16777231
	if player == "P2":
		left_move = 65
		
	return left_move

func _get_right(player):
	if player == "P1":
		right_move = 16777233
	if player == "P2":
		right_move = 68
		
	return right_move
