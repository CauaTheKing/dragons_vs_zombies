extends ZumbiBase

func attaking() -> void:
	if global_position.distance_to(Global.player.global_position) > attack_distance:
		change_state(STATES.MOVE_TO_TARGET)
		
	start_anim('attack')


func _on_sprite_animation_finished():
	if sprite_animated.animation == 'death':
		queue_free()
