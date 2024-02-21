extends CharacterBody2D
class_name ZumbiBase

@export var life: int
@export var speed: int
@export var damage: int
@export var attack_distance: int
@onready var _sprite_animated: AnimatedSprite2D = $Sprite
@export var anim_player: AnimationMixer


enum STATES {ATTACKING = 1, MOVE_TO_TARGET, IDLE, THROW}
#var list_anim: Array
var current_state: int
var target
var target_direction: Vector2
var default_speed: int

func set_sprite_flip(value) -> bool:
	if not value is bool:
		if not (value is float or value is int):
			return false
		value = bool(value)
	
	_sprite_animated.flip_h = value
	return value


func _ready():
	default_speed = speed
	add_to_group('zumbi')
	get_target()
	#list_anim = sprite_animated.sprite_frames.get_animation_names()
	
func change_state(_state: int) -> void:
	current_state = _state
	
func start_anim(_anim: String = '') -> void:
	if not anim_player: return
	
	
	var anim_lib: AnimationLibrary = null
	anim_lib = anim_player.get_animation_library("")
	
	if anim_lib == null:
		return
	
	if anim_player is AnimationPlayer:
		if life <= 0:
			var do_ret := false
			
			if anim_player.get_current_animation() == 'death':
				do_ret = true
			else:
				anim_player.play('death')
			
			if anim_lib is AnimationLibrary and anim_lib.has_animation('walk'):
				anim_lib.remove_animation('walk')
			
			if do_ret: return
			
			#if sprite_animated.animation != 'death' or not sprite_animated.is_playing():
				#sprite_animated.stop()
				#sprite_animated.play('death')
				#return

		#match _anim:
			#'death':
				#if life > 0:
					#sprite_animated.stop()
				# MODIFICAÇÃO: ADICIONADO IF-STATE PARA CHECHAR SE A VIDA
				# NÃO ESTÁ ZERADA. SE NÃO ESTIVER, IRÁ PARAR A ANIMAÇÃO
		
		anim_player.play(_anim)

		if anim_lib.has_animation('walk') and anim_player.get_current_animation() == 'walk':
			set_sprite_flip(global_position.direction_to(Global.player.global_position).x < 0)
	
func _physics_process(delta):

	match current_state:
		STATES.MOVE_TO_TARGET:
			move_to_target()
		STATES.ATTACKING:
			if has_method('attaking'):
				call_deferred('attaking')
		STATES.THROW:
				throw(delta)
					
func get_target() -> void:
	target = Global.player
	
	start_anim('walk')
	rotation = 0
	change_state(STATES.MOVE_TO_TARGET)

func throw(delta) -> void:
	
	velocity = global_position.direction_to(target_direction)
	
	global_translate(velocity * speed * 2 * delta)
	start_anim('spin')
	if global_position.distance_to(target_direction) < 10:
		get_target()
			
func move_to_target() -> void:
	if not target or life <= 0:
		return
	
	$Label.text = 'speed: ' + str(speed)
	var distance_to_target = global_position.distance_to(target.global_position)
	var direction_to_target: Vector2 = global_position.direction_to(target.global_position)
		
	velocity = direction_to_target * speed
	move_and_slide()
	
	start_anim('walk')
	
	if distance_to_target < attack_distance:
		change_state(STATES.ATTACKING)
		
func take_damage(_dmg: int) -> void:
	life -= _dmg
	
	$HitTextEffect.play_effect(_dmg)
	
	if life <= 0:
		change_state(STATES.IDLE)
		start_anim('death')
		
# =========================
# funcs chamadas por outros nodes

func ice_effect(_value: bool) -> void:
	if _value:
		speed = int(default_speed/3)
		modulate = '#006bf7'
		return
		
	speed = default_speed
	modulate = '#ffffff'

	
		
