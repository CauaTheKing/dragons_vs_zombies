extends Node

var player: CharacterBody2D

func add_impact_area(_position: Vector2, anim_name: String, _damage: int) -> void:
	var new_area_impact = preload('res://Scenes/GamePlay/impact_scene.tscn').instantiate()
	new_area_impact.global_position = _position
	get_tree().root.call_deferred('add_child', new_area_impact)
	new_area_impact.set_anim(anim_name, _damage)

	

