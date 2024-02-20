extends Area2D
class_name BulletBase

var speed: int
var target
var target_position: Vector2
var target_direction: Vector2
var direct_damage: int
var impact_damage: int
var list_anim: Array
var dragon: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var shape: CollisionShape2D
@export var anim: AnimationPlayer

func _ready():
	set_process(false)
	list_anim = sprite.sprite_frames.get_animation_names()
	
func _process(delta):

	var direction: Vector2 = target_direction * speed

	global_translate(direction)
	
	if list_anim.has('move'):
		sprite.play('move')
	
	if global_position.distance_to(target_position) < 10:
		if has_method('explode'):
			call_deferred('explode')
		
func set_damage(direct: int, impact: int, _dragon: CharacterBody2D) -> void:
	direct_damage = direct
	impact_damage = impact
	dragon = _dragon


func set_bullet(_spawn: Vector2, _target, _speed: int) -> void:
	if not _target:
		queue_free()
		return

	target = _target
	speed = _speed
	global_position = _spawn
	if anim:
		if anim.get_animation('start') != null:
			anim.play('start')
