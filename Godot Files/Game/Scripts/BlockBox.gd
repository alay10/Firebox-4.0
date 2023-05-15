extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const hit_duration = 0.15
@export (ShaderMaterial) var blue_material

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_BlockBox_area_entered(area):
	blue_material.set_shader_parameter("blockFX", true)
	await get_tree().create_timer(hit_duration).timeout
	blue_material.set_shader_parameter("blockFX", false)


