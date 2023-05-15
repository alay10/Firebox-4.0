extends Node

var battle_music = load("res://Music/chunli.mp3");
var basic_music = load("res://Music/gilu.wav");
var hit_sound = load("res://Music/Hit-SFX.wav");
var block_sound = load("res://Music/Block-SFX.wav");
var parry_sound = load("res://Music/Maybe_Parry-SFX.wav");

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

func sf_attack():
	$hit.stop()
	$hit.stream = hit_sound
	$hit.play()

func st_block():
	$hit.stop()
	$hit.stream = block_sound
	$hit.play()

func sf_parry():
	$hit.stream = parry_sound
	$hit.play()

func sf_block():
	$hit.stream = block_sound
	$hit.play()

func set_master(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
func set_music(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
func set_sfx(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
