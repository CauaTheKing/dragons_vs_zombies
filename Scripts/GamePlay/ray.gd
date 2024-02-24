extends Node2D

func start() -> void:
	$Sprite.frame = 0
	$Sprite.play('ray')

func _on_sprite_animation_finished():
	queue_free()
