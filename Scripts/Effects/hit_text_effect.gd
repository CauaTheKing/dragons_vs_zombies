extends Node2D

func play_effect(damage: int) -> void:
	visible = true
	$Label.text = str(damage)
	$Anim.play('start')


func _on_anim_animation_finished(anim_name):
	visible = false
