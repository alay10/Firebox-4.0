extends Node2D

var fspeed = 5
var bspeed = 3

func execute(s, dir):
	s.velocity = Vector2()
	
	if(dir == "right"):
		s.velocity.x += 1 * fspeed
	if(dir == "left"):
		s.velocity.x -= 1 * fspeed
		
	s.velocity = s.velocity.normalized()
	s.set_velocity(s.velocity * s.max_speed)
	s.move_and_slide()
	s.velocity = s.velocity
