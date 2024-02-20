extends Node2D

@export var sprite: AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = get_node('area/shape')
@export var area: Area2D

var anim: String
var damage: int

func _ready():
	sprite.frame = 0

func set_anim(_anim: String, _dmg: int) -> void:
	damage = _dmg
	sprite.play(_anim)


func _on_sprite_animation_finished():
	var zumbis: Array = area.get_overlapping_bodies()

	for z in zumbis:
		if z.has_method('take_damage'):
			z.take_damage(damage)
	queue_free()

