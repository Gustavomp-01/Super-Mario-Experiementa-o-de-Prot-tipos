extends CharacterBody2D


class_name Player

@export_group("Locomotion")
@export var speed = 200
@export var jump_velocity = -350
@export var run_speed_damping = 0.5

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity = -150

var is_dead = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y *= 0.5
		
	var direction = Input.get_axis("Left","Right")
	
	if direction:
		velocity.x = lerp(velocity.x, speed * direction, run_speed_damping * delta)
	else:
		velocity.x = move_toward(velocity.x, 0 , speed * delta)
	
	$Animacao.trigger_animation(velocity, direction)
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	if not (area is Enemy) or is_dead:
		return
	
	if area is Koopa and (area as Koopa).in_a_shell:
		(area as Koopa)._on_stomp(global_position)
		return
	
	var angle = rad_to_deg(position.angle_to_point((area as Enemy).position))
	
