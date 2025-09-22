extends Enemy

class_name Goomba

func _die():
	super._die()
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	get_tree().create_timer(0.5).timeout.connect(queue_free)

func _on_area_entered(area):
	if area is Koopa and (area as Koopa).in_a_shell and (area as Koopa).h_speed != 0:
		_die_from_hit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
