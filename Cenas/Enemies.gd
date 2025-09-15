extends Area2D

class_name Enemy


@export var h_speed = 20
@export var v_speed = 100
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@omready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	position.x -= h_speed * delta
	
	if !ray_cast_2d.is_colliding():
		position.y += v_speed * delta

func _die():
	h_speed = 0
	v_speed = 0
	animated_sprite_2d.play("dead")
