extends CharacterBody2D

#setting the intial speed and gravity 
@export var speed = 40
@export var Gravity = 5

#defines the 2d motion 
var Motion = Vector2.ZERO

# function for movement, now we have left and right but 
# we can set up up and down movement if needed 
func _physics_process(delta):
	
	var Direction = 0
	if Input.is_action_pressed("LEFT"):
		Direction -= 1
	if Input.is_action_pressed("RIGHT"):
		Direction += 1
	if Direction == 0:
		Motion.x = 0
	else:
		Motion.x = Direction * speed

	#perform the movement in actual game 
	Motion.y += Gravity
	set_velocity(Motion)
	set_up_direction(Vector2.UP)
	move_and_slide()
	Motion = velocity
