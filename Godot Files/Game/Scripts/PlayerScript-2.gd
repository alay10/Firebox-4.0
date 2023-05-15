extends KinematicBody2D


# export var moveLeft = KEY_LEFT
# export var moveRight = KEY_RIGHT
# export var kick = KEY_DOWN
# export var jump = KEY_UP

var controler = preload("res://Game/AnimatedPlayer/test/Controler.gd")

export(float) var MAX_HEALTH: float = 10.0
onready var health: float = MAX_HEALTH

var P_layer
var moveLeft = KEY_LEFT
var moveRight = KEY_RIGHT
var inputBuffer = "0"
var other
var flipped = false

# Movement Values
var flippedMotion = 1
var friction = .5
var BlockingFriction = .85
var CrouchingFriction = .88
var motion = Vector2(0, 0)
var HitStunVec = Vector2(35000, -10000)
var BlockStunVec = Vector2(70000, 0)
var dashing = false
var dF = false
var dB = false
var airDashes = 1
var Special_cancel = false

var jumpCancel = false

# Motion speeds and multiplyers
var forwardSpeed = 35000
var backwardSpeed = 25000
var dashingSpeed = 150000
var fMotion
var bMotion
export(int) var jumpMultiplier = 150000
export(float) var airSpeedMultiplier = .975
export(int) var gravityMultiplier = 8000
var airDashMultiplyer = 1
var Delta
var GravMod = 1.0


# FireBall Values
var Fireball
class fireball:
	var instance
	var scene = load("Game/FireBall.tscn")
	var active = false

	var Startup = 30

	export(int) var Lag = 30
	var buffer = 0
	var timer

# Uppercut Values
var Uppercut
var inUppercut = false
export(Vector2) var UppercutMotion
var UppercutStartup = 15

export(int) var UppercutLag= 70
var uppercut_buffer = 0
var uppercut_timer = 0


#kick varibles
export(int) var kickEndLag = 30
var kickActiveFrames = 5
var kickStartup = 13
var kickTimer = 0


# Jump punch varibles
var JumpPunchLag = 45
var JumpPunchvec = Vector2(37500, 47000)

#Jab Variables
export(int) var jabEndLag = 10
var jabTimer = 0

# Parry Variables
export(int) var parryWindow = 3
export(int) var parryStun = 3
var parrying = false

#timers
var inputTimerArray = [0]
var bufferWindow = 0
var dashTimer = 0
var timer = 0
var lagTimer = 0
var hitstun = 0
var parryTimer = 0
var blockstun = 0

# SHADER
export (ShaderMaterial) var shader
export var hitColor = Vector3(1, 0, 0)
export var blockingColor = Vector3(0.15, 0.15, 0.15)
export var blockedColor = Vector3(1, 1, 0)
export var parryColor = Vector3(0, 1, 1)


# SHADING FUNCTIONS
func shadePlayer(color: Vector3, strength: float):
	shader.set_shader_param("shading", true)
	shader.set_shader_param("strength", strength)
	shader.set_shader_param("customColor", color)
	
func disableShading():
	shader.set_shader_param("shading", false)

# Returns true if player is on the left
func onLeft():
	if self.name == "P1":
		if get_parent().get_node("P2").get_position().x > self.get_position().x:
			return true
		else:
			return false
	else:
		if get_parent().get_node("P1").get_position().x > self.get_position().x:
			return true
		else:
			return false

# This will check if the player has crossed to the other side
# This will also only flip if the player is on the groud
func hasFliped():
	if get_position().x < get_parent().get_node(str(other)).get_position().x and is_on_floor():
		if !flipped:
			flipped = true
			return true
	elif get_position().x > get_parent().get_node(str(other)).get_position().x and is_on_floor():
		if flipped:
			flipped = false
			return true
	return false
	
func flipPlayer():
	if flipped:
		# player things
		# Left side
		$PlayerSprite.offset = Vector2(110, 0)
		$PlayerSprite.flip_h = true
		fMotion = "move_right"
		bMotion = "move_left"
		flippedMotion = -1
		
		# lol
		$HurtBox.position.x = -14
		$kickBox.scale.x = -1
		$jabBox.scale.x = -1
		$DP.scale.x = -1
		$Jump_punch.scale.x = -1
		#$Airkick.scale.x = -1
					
	else:
		# Right side
		get_node("PlayerSprite").offset = Vector2(0, 0)
		get_node("PlayerSprite").flip_h = false
		fMotion = "move_left"
		bMotion = "move_right"
		flippedMotion = 1
		
		# lol
		$HurtBox.position.x = 3
		$kickBox.scale.x = 1
		$jabBox.scale.x = 1
		$DP.scale.x = 1
		$Jump_punch.scale.x = 1
		#$Airkick.scale.x = 1

func inCheck(var inputList):
	for inputName in inputList:
		if Input.is_action_pressed(self.name + inputName):
			return inputName
	return null

func AnimationCheck(var input):
	if input == fMotion:
		get_node("PlayerSprite").play("Walk")
	elif input == "_Down":
		get_node("PlayerSprite").play("Crouch")
	else: 
		get_node("PlayerSprite").play("Stand")

func applyMotion(var input, var delta):
	if input == fMotion:
		motion.x -= forwardSpeed * delta * flippedMotion
	if input == bMotion:
		motion.x += backwardSpeed * delta * flippedMotion

# Helper function for dash check
func dashStart():
	dashing = true
	lagTimer = 6
	dashTimer = timer + 12
	jumpCancel = true
	friction = .95
	if is_on_floor() == false:
		airDashMultiplyer = 0

func dashCheck():
	if (inputBuffer.findn("66", inputBuffer.length()-get_buffer_window(18)) != -1) and not dF:
		dF = true
		dashStart()
	if (inputBuffer.findn("44", inputBuffer.length()-get_buffer_window(18)) != -1) and not dB:
		dB = true
		dashStart()

func reset_dash():
	#Resets dash varibles
	if dashTimer < timer:
		friction = 0.5
		jumpCancel = false
		airDashMultiplyer = 1
	# Dashing Lockout window 
	if dashTimer+6 < timer:
		dashing = false
		dF = false
		dB = false

# The call when you want to dash
func dash(var delta):
		if dF:
			motion.x -= dashingSpeed * delta * flippedMotion
			$PlayerSprite.play("Dash")
		if dB:
			motion.x += dashingSpeed * delta * flippedMotion
			$PlayerSprite.play("Dashback")

# all the bufferd input checking
# The inputBuffer 
func checkInput():
	if Input.is_action_just_pressed(self.name + "_Down"):
		inputBuffer = inputBuffer + "2"
		inputTimerArray.push_back(timer)
	if Input.is_action_just_pressed(self.name + str(fMotion)) and Input.is_action_pressed(self.name + "_Down"):
		inputBuffer = inputBuffer + "3"
		inputTimerArray.push_back(timer)
	if Input.is_action_just_pressed(self.name + str(bMotion)) and Input.is_action_pressed(self.name + "_Down"):
		inputBuffer = inputBuffer + "1"
		inputTimerArray.push_back(timer)
	if Input.is_action_just_pressed(self.name + str(fMotion)) and !Input.is_action_just_pressed(self.name + "_Down"):
		inputBuffer = inputBuffer + "6"
		inputTimerArray.push_back(timer)
	if Input.is_action_just_pressed(self.name + str(bMotion)) and !Input.is_action_just_pressed(self.name + "_Down"):
		inputBuffer = inputBuffer + "4"
		inputTimerArray.push_back(timer)

	if inputTimerArray.size() > 0:
		if inputTimerArray[0]+150 < timer:
			inputTimerArray.pop_front()

# finds the ammount of buffered inputs inputted after a certin ammount of frames
func get_buffer_window(var frames):
	for i in inputTimerArray.size():
		if inputTimerArray[i]+frames > timer:
			return inputTimerArray.size() - i
	return 0

# Checks for if the fire ball should be cast
func fireball_check():
	if timer > Fireball.buffer:
		if (inputBuffer.findn("236", inputBuffer.length()-get_buffer_window(20)) != -1):
			print("Fireball Ready")
			Fireball.buffer = timer+80

	if (timer < Fireball.buffer) and Input.is_action_just_pressed(self.name + "_Attack") and (lagTimer == 0):
		Fireball.active = true
		lagTimer = Fireball.Startup + Fireball.Lag

func throw_fireball():
	$fireballAnim/fireballAnimation.play("fire")
		
	if lagTimer == Fireball.Startup:
		Fireball.instance = Fireball.scene.instance()
		get_parent().add_child(Fireball.instance)
		Fireball.instance.init(self.position, onLeft(), self, shader.get_shader_param("headBand"))
		Fireball.instance.position += Vector2(0, 70)
		Fireball.instance.scale = Vector2(.7,.7)

func Reset_Fireball():
	Fireball.active = false

func jab_check(var input):
	if input == null and Input.is_action_just_pressed("%s_Attack" % self.name) and lagTimer == 0:
		$jabBox/AnimationPlayer.play("jab")
		lagTimer = jabEndLag

func kick_check():
	if Input.is_action_pressed(self.name + "_Down") and Input.is_action_just_pressed("%s_Attack" % self.name) and lagTimer == 0:
		$kickBox.visible = true
		$kickBox/kickAnimation.play("kick")
		lagTimer = kickEndLag
		kickTimer = timer + kickEndLag
	
	if kickTimer < timer:
		$kickBox.visible = false

func air_kick_check():
	if Input.is_action_just_pressed(self.name + "_Attack") and lagTimer == 0:
		$Airkick/AnimationPlayer.play("Airkick")

func reset_air_kick():
	$Airkick/AnimationPlayer.play("RESET")

func jump_punch_check(input):
	if input == fMotion and Input.is_action_just_pressed(self.name + "_Attack") and lagTimer == 0:
		print("Jump attack")
		return true
	return false

func jump_punch():
	$Jump_punch/AnimationPlayer.play("Jump_punch")
	motion.x = -(JumpPunchvec.x * Delta * flippedMotion)
	motion.y -= JumpPunchvec.y * Delta
	GravMod = 0.3
	lagTimer = JumpPunchLag

func reset_grav():
	GravMod = 1.0

func Uppercut_check():
	if timer > uppercut_buffer:
		if (inputBuffer.findn("623", inputBuffer.length()-get_buffer_window(25)) != -1):
			print("Uppercut Ready")
			uppercut_buffer = timer+60

	if (timer < uppercut_buffer) and Input.is_action_just_pressed(self.name + "_Attack") and not inUppercut:
		Reset_Fireball()
		inUppercut = true
		uppercut_timer = timer + UppercutStartup + UppercutLag
		lagTimer = UppercutStartup + UppercutLag

func Uppercut():
	if uppercut_timer == UppercutStartup + UppercutLag + timer:
		$DP/AnimationPlayer.play("Dragon punch")
	if timer < (uppercut_timer - UppercutLag):
		motion.x -= UppercutMotion.x * Delta * flippedMotion
		motion.y -= UppercutMotion.y * Delta

func Reset_Uppercut():
	inUppercut = false
	
func parry_check(var input):
	
	if Input.is_action_just_pressed(self.name + str(fMotion)):
		parrying = true
		parryTimer = timer
	
	if (timer - parryTimer > parryWindow):
		parrying = false
		

##########################################################################
# Blocking check
# This now works on layers:
# P_layer is the current players low hitboxes (P1 = 1) (P2 = 3) Zero indexed
# P_layer+8 is the High hitbox
# P_layer+16 is the mid Hitbox
# Any number + 1 is the Hurtbox variant
func block_check(var input):
	var Priority_in = inCheck([fMotion, bMotion])
	if Priority_in == bMotion and lagTimer == 0:
		$BlockBox/BlockingBox.disabled = false
		$BlockBox.visible = true
		
		# Turn on blocking shader
		shadePlayer(blockingColor, 0.6)
		
		get_node("BlockBox").set_collision_layer_bit(P_layer+1+16, 1)
		get_node("HurtBox").set_collision_layer_bit(P_layer+1+16, 0)
		if input == "_Down":
			get_node("BlockBox").set_collision_layer_bit(P_layer+1, 1)
			get_node("BlockBox").set_collision_layer_bit((P_layer+1)+8, 0)
			
			get_node("HurtBox").set_collision_layer_bit(P_layer+1, 0)
			get_node("HurtBox").set_collision_layer_bit((P_layer+1)+8, 1)
		else:
			get_node("BlockBox").set_collision_layer_bit(P_layer+1+8, 1)
			get_node("BlockBox").set_collision_layer_bit((P_layer+1), 0)
			
			get_node("HurtBox").set_collision_layer_bit(P_layer+1+8, 0)
			get_node("HurtBox").set_collision_layer_bit((P_layer+1), 1)
	else:
		reset_block()
func reset_block():
	get_node("HurtBox").set_collision_layer_bit(P_layer+1, 1)
	get_node("HurtBox").set_collision_layer_bit(P_layer+1+8, 1)
	get_node("HurtBox").set_collision_layer_bit(P_layer+1+16, 1)
	$BlockBox.visible = false
	$BlockBox/BlockingBox.disabled = true
	$HurtBox/CollisionShape2D.disabled = false
	
	# Turn off blocking shader
	disableShading()

func jump_check():
	if Input.is_action_pressed("%s_Jump" % self.name) and ((lagTimer == 0) or jumpCancel):
		return true
	else:
		return false

func jump(var delta):
	motion.y = -jumpMultiplier * delta
	get_node("PlayerSprite").play("Jump")
	reset_block()
	if not jumpCancel:
		motion.x *= 2.5
	else:
		motion.x *= 1.2
		reset_dash()
		reset_block()
	# is_on_floor() is a function that just works ig
	
func apply_Hit_Stun(var HitVec):
	motion = HitVec * Vector2(Delta, Delta)
	motion.x *= flippedMotion
	
	if is_on_floor():
		motion.y *= 1.4

func apply_Block_stun(var BlockVec):
	motion = BlockVec * Vector2(Delta, Delta)
	motion.x *= flippedMotion
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if self.name == "P1":
		other = "P2"
		P_layer = 1
		Global.p1_Health = health
	else:
		P_layer = 3
		other = "P1"
		Global.p2_Health = health
	fMotion = "move_left"
	bMotion = "move_right"
	controler = controler.new()
	moveLeft = controler._get_left(self.name)
	moveRight = controler._get_right(self.name)
	$jabBox/ColorRect.visible = false
	
	#MusicControl.stop()
	MusicControl._paly_battle_music()
	Fireball = fireball.new()
	
	# Shader Shenanigans
	if self.name == "P1" :
		
		print("Setting P1 Shader Params")
		shader.set_shader_param("headBand", Global.p1_headband_color)
		shader.set_shader_param("body", Global.p1_body_color)
		get_parent().get_node("UI/P1_HealthBar/ColorRect").color = Global.p1_headband_color
		

	if self.name == "P2" :
		
		print("Setting P1 Shader Params")
		shader.set_shader_param("headBand", Global.p2_headband_color)
		shader.set_shader_param("body", Global.p2_body_color)
		get_parent().get_node("UI/P2_HealthBar/ColorRect").color = Global.p2_headband_color
		
		


func _physics_process(delta):
	Delta = delta
	# Simple timer varible
	timer += 1

	# Buffered input handling
	
	checkInput()
	
	
	
	var input
	if lagTimer == 0:
		input = inCheck(["_Down",fMotion, bMotion])
		
		#Checking if the sprite just flipped, make sure that this isn't done while in hitstun
		if hasFliped():
			flipPlayer()
			# For resetting dashing
	if dashing and dashTimer < timer:
		reset_dash()
	if hitstun < timer and blockstun < timer:
		
		if is_on_floor():
			reset_air_kick()
			if lagTimer == 0:
				Reset_Uppercut()
				Reset_Fireball()
				reset_grav()
			#sets the air dashes back to 1 if the player is on the ground
			airDashes = 1
			# Animation
			if lagTimer == 0:
				AnimationCheck(input)

			# Basic Movement
			if input != null and lagTimer == 0:
				applyMotion(input, delta)

			# Uppercut
			Uppercut_check()
			
			if inUppercut:
				Uppercut()
				
			# end of uppercut

			# Fireball
			fireball_check()
			
			if Fireball.active:
				throw_fireball()

			# end of Fireball
			
			
			jab_check(input)
			
			#kick (badly named, will likely get changed)
			kick_check()

			if jump_punch_check(input):
				jump_punch()
			# Blocking (badly named, will likely get changed)
			block_check(input)
			
			parry_check(input)

			# Jumping
			if jump_check():
				jump(delta)
		else:
			air_kick_check()
		#dashing

		
		if lagTimer == 0 and dashTimer < timer and not dashing:
			#dealing with air dashes
			if airDashes != 0:
				dashCheck()
				if dashTimer > timer:
					airDashes -= 1
					dash(delta)
	#elif timer < hitstun:
	#	applyHitStun(delta)
		#end of dashing
		
		# Control horizontal speed
	if is_on_floor():
		if timer < blockstun:
			motion.x *= BlockingFriction
		elif input == "_Down":
			motion.x *= CrouchingFriction
		else:
			motion.x *= friction
		if motion.y > 50:
			motion.y = 0
	else:
		motion.y += gravityMultiplier * delta * GravMod
		motion.x *= airSpeedMultiplier
		
		# Apply all changes in movement
	motion.y *= airDashMultiplyer
	move_and_slide(motion, Vector2.UP)
	
	# Update lag timer
	if lagTimer > 0:
		lagTimer -= 1
		disableShading()
		
	if blockstun == timer:
		disableShading()
		
	
	if (health <= 0) and is_on_floor():
		print(self.name, " Has lost")
		Global.win_player = self.name
		get_tree().change_scene("res://Game/WIN.tscn")


# THIS IS WHERE WE WILL HANDLE BEING HIT
func _on_HurtBox_area_entered(area):
	
	# CHECK FOR PARRY
	if (parrying):
		# PLAY PARRY SFX
		shadePlayer(parryColor, 0.6)
		area.get_node("hitbox").disabled = true
		hitstun = timer + parryStun
		return
		
	#PLAY SOUNDEFFECT HERE
	MusicControl.sf_attack()
	
	# Hitstun
	hitstun = timer + area.Hitstun
	apply_Hit_Stun(area.HitstunVec)
	# Damage
	health -= area.Damage 
	
	# Update Health var
	if self.name == "P1":
		Global.p1_Health = health
	else:
		Global.p2_Health = health
	
	# Update health bar
	var path = "UI/"+self.name+"_HealthBar"
	get_parent().get_node(path).updateHealthBar(health/MAX_HEALTH)

	# Make player turn red
	shadePlayer(hitColor, 0.6)

func _on_BlockBox_area_entered(area):
	#MusicControl.block_sound
	
	# Turn on hit block shader
	shadePlayer(blockedColor, 0.6)
	
	# Put player into blockstun
	blockstun = timer + area.Blockstun
	apply_Block_stun(area.BlockstunVec)
