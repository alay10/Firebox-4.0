extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const hit_duration = 0.15
@export (ShaderMaterial) var red_material

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called for shader effects
# Redundant now
func _on_HurtBox_area_entered(area):
	
	red_material.set_shader_parameter("hitFX", true)
	await get_tree().create_timer(hit_duration).timeout
	red_material.set_shader_parameter("hitFX", false)
	
	
