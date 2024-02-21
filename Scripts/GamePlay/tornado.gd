extends Area2D

func attacking() -> void:
	var zumbis: Array = get_overlapping_bodies()
	
	if zumbis.is_empty(): return
	
	for z in zumbis:
		z.throw()


func _on_body_entered(body):
	body.target_direction = body.global_position + Vector2(randi_range(-300, 300), randi_range(-300, 300))
	body.change_state(4)
