extends CharacterBody2D
class_name ZumbiBase

@export var life: int
@export var speed: int
@export var damage: int
@export var attack_distance: int
@export var sprite_animated: AnimatedSprite2D

enum STATES {ATTACKING = 1, MOVE_TO_TARGET, IDLE}
var list_anim: Array
var current_state: int
var target
var target_direction: Vector2


func _ready():
	add_to_group('zumbi')
	target = Global.player
	change_state(STATES.MOVE_TO_TARGET)
	list_anim = sprite_animated.sprite_frames.get_animation_names()
	
func change_state(_state: int) -> void:
	current_state = _state
	
func start_anim(_anim: String = '') -> void:
	if not sprite_animated:return
	
	print(_anim)
	
	if life <= 0:
		if sprite_animated.animation != 'death' or not sprite_animated.is_playing():
			sprite_animated.stop()
			sprite_animated.play('death')
			return

	match _anim:
		'death':
			if life > 0:
				sprite_animated.stop()
			# MODIFICAÇÃO: ADICIONADO IF-STATE PARA CHECHAR SE A VIDA
			# NÃO ESTÁ ZERADA. SE NÃO ESTIVER, IRÁ PARAR A ANIMAÇÃO
	
	sprite_animated.play(_anim)

	if sprite_animated.animation == 'walk':
		sprite_animated.flip_h = global_position.direction_to(Global.player.global_position).x < 0
	
func _physics_process(delta):

	match current_state:
		STATES.MOVE_TO_TARGET:
			move_to_target()
		STATES.ATTACKING:
			if has_method('attaking'):
				call_deferred('attaking')
				
			
func move_to_target() -> void:
	if not target or life <= 0:
		return

	var distance_to_target = global_position.distance_to(target.global_position)
	var direction_to_target: Vector2 = global_position.direction_to(target.global_position)
		
	velocity = direction_to_target * speed
	move_and_slide()
	
	start_anim('walk')
	
	if distance_to_target < attack_distance:
		change_state(STATES.ATTACKING)
		
func take_damage(_dmg: int) -> void:
	life -= _dmg
	
	get_node('HitTextEffect').play_effect(_dmg)
	
	if life <= 0:
		change_state(STATES.IDLE)
		start_anim('death')

		