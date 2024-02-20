extends BulletBase

func explode(body = null) -> void:
	if body:
		body.take_damage(direct_damage)
		
	Global.add_impact_area(global_position,'fire',impact_damage)
	print(target_position, '   explosao')

	queue_free()

func _on_anim_animation_finished(anim_name):
	if not target:
		queue_free()
		return
		
	if anim_name == 'start':
		look_at(target.global_position)
		target_direction = global_position.direction_to(target.global_position)
		target_position = target.global_position
		set_process(true)


func _on_body_entered(body):
	if body.has_method('take_damage'):
		explode(body)
