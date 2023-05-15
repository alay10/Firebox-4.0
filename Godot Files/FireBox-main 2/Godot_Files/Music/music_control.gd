extends Node

var battle_music = load("res://Music/chunli.mp3");
var basic_music = load("res://Music/gilu.wav");
var stop_music = true
func _ready():
	pass
	
func _paly_battle_music():
	$Music.stop()
	$Music.stream = battle_music
	$Music.play()
	stop_music = true

func _paly_basic_music():
	if stop_music:
		stop_music = false
		$Music.stop()
		$Music.stream = basic_music
		$Music.play()
	
func stop():
	$Music.stop()
