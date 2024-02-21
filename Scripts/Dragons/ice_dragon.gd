extends DragonBase

@onready var freeze_area: Area2D = $FreezingArea
@onready var sprite_freeza: AnimatedSprite2D = $FreezingArea/Sprite

func close_attack() -> void:

	var zumbis: Array = freeze_area.get_overlapping_bodies()
	
	if zumbis.is_empty() or not target:
		freeze_area.visible = false
		sprite_freeza.stop()
		return
		
	freeze_area.visible = true
	sprite_freeza.play('freeze')
	freeze_area.look_at(target.global_position)
	for z in zumbis:
		z.ice_effect(true)

func state_idle() -> void:
	pass

func _on_freezing_area_body_exited(body):
	body.ice_effect(false)
