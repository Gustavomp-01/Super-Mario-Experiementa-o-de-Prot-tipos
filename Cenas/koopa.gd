extends Enemy

class_name Koopa

@onready var collision_shape_2d = $CollisionShape2D
var koopa_full = preload("res://Collisions/koopa_full.tres")
var koopa_shell = preload("res://Collisions/koopa_shell.tres")
var koopa_shell_position = Vector2(0,5)
var in_a_shell = false
@export var slide_speed = 200

func _ready():
	collision_shape_2d.shape = koopa_full

func _die():
	if !in_a_shell:
		super._die()
	in_a_shell = true
	collision_shape_2d.set_deferred("shape", koopa_shell)
	collision_shape_2d.set_deferred("position", koopa_shell_position)

func _on_stomp(player_position: Vector2):
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(4, true)
	set_collision_mask_value(3, true)
	
	var movement_direction = 1  if player_position.x <= global_position.x else -1 
	h_speed = - movement_direction * slide_speed
	



func _on_area_entered(area):
	if area is Koopa and (area as Koopa).in_a_shell and (area as Koopa).h_speed != 0:
		_die_from_hit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
