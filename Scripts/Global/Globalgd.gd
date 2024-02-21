extends Node

var player: CharacterBody2D

func add_impact_area(_position: Vector2, anim_name: String, _damage: int) -> void:
	var new_area_impact = preload('res://Scenes/GamePlay/impact_scene.tscn').instantiate()
	new_area_impact.global_position = _position
	get_tree().root.call_deferred('add_child', new_area_impact)
	new_area_impact.set_anim(anim_name, _damage)
	
func rotate_area_to_target(target: CharacterBody2D, area: Area2D) -> void:
	
	var rotation_speed: float = 90.0
	var target_position: Vector2 = target.global_position
	var area_position: Vector2 = area.global_position
	
	var direction: Vector2 = area_position.direction_to(target_position)
	var angle: float = rad_to_deg(atan2(direction.y, direction.x))
	
	

