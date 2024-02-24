extends Area2D

func set_shape(_lenght: int) -> void:
	$Shape.shape.radius = _lenght

func get_targets_by_group(group_target: String) -> Array:
	var targets_in_area: Array = get_overlapping_bodies()
		
	var list_target: Array = []
	
	for t in targets_in_area:
		if t.is_in_group(group_target):
			list_target.append(t)
	
	return list_target


func get_random_target(body_self:CharacterBody2D, group_target: String) -> CharacterBody2D:
	var list_targets: Array = get_targets_by_group(group_target)
	
	if list_targets.is_empty(): return null
	
	var target : CharacterBody2D
		
	target = list_targets.pick_random()
	
	return target

func get_next_target(body_self:CharacterBody2D, group_target: String) -> CharacterBody2D:
	var list_targets: Array = get_targets_by_group(group_target)
	
	if list_targets.is_empty(): return null
	
	var next_target: CharacterBody2D = list_targets.pick_random()
	
	var distance_to_next = body_self.global_position.distance_to(next_target.global_position)
	
	for t in list_targets:
		if body_self.global_position.distance_to(t.global_position) < distance_to_next or not next_target:
			next_target = t

	return next_target
	
