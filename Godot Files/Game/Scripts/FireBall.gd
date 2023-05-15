extends Area2D


# who is throwing the fireball
var thrower

# FireBall Initial Position
var initial_position

export(Vector2) var HitstunVec
export(Vector2) var BlockstunVec
export(int) var Hitstun
export(int) var Blockstun
export(int) var Damage

export(int) var fireBallDuration = 150
export var fireBallSpeed = Vector2(17, 0)

func _ready():
	
	pass

func init(position: Vector2, onLeft: bool, thrower: KinematicBody2D, color: Color):
	
	# just in case we change anything and need it
	self.thrower = thrower
	
	$ColorRect.color = color
	
	initial_position = position
	initial_position.y = 550
	
	# If we are on the right side change the fireball speed
	if not onLeft:
		fireBallSpeed.x *= -1
		
	# Make sure fireball is visible and give appropriate position
	self.visible = true
	self.set_position(initial_position)
	
	# Set the collisions properly
	if thrower.name == "P1":
		# is a p1_mid_hitbox
		set_collision_layer_bit(17, true)
		
		# can be detected by p2_mid_hitbox and p2_mid_hurtbox
		set_collision_mask_bit(20, true)
	else:
		# is a p2_hitbox
		set_collision_layer_bit(19, true)
		
		# can be detected by p1_hitbox and p1_hurtbox
		set_collision_mask_bit(18, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Check on timer and decrement
	if fireBallDuration > 0:
		fireBallDuration -= 1
	else: 
		self.queue_free()

	# Move the fireball
	self.set_position(position + fireBallSpeed)

		



# Whenever the fireball hits something in its mask this is called
func _on_FireBall_area_entered(area):
	
	# to start i just make the duration 0 killing it
	fireBallDuration = 0
	pass # Replace with function body.
