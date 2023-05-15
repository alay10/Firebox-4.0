extends "res://Game/Scripts/Test player.gd"

var ai_think_time = 0.7
var ai_think_time_timer = null

#set up 
func _onready():
	target = $"../Player"
	is_ai_controlled = true
	speed = 50
	setup_ai_think_time_timer()
	._onready()

	
func ai_get_direction():
			return target.position - self.position

func ai_move():
	var direction = ai_get_direction()
	var motion = direction.normalized() * speed
	move_and_slide(motion)

func setup_ai_think_time_timer():
	ai_think_time_timer = Timer.new()
	ai_think_time_timer.set_one_shot(true)
	ai_think_time_timer.set_wait_time(ai_think_time)
	ai_think_time_timer.connect("timeout", self, "on_ai_thinktime_timeout_complete")
	add_child(ai_think_time_timer)
	
	
#need to detect the health state of the player
## need to add a get_state() func in player script
	
func decide_to_attack():
	ai_think_time_timer.start()

func on_ai_thinktime_timeout_complete():
	if is_in_range && state == 0 && target.get_state() == 0:
			attack()
		
func _process(delta):
	if state == 0 && target.get_state() == 0:
		if is_in_range && ai_think_time_timer.time_left == 0:
			decide_to_attack()
		else:
			ai_move()
			
			
## need a take damage function to calling queue free on player collison shape when the players helth is 0 			
