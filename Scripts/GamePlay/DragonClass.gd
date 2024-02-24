extends CharacterBody2D
class_name DragonBase

@export var lifes: int #a vida do dragao (imagina que um ataque padrão de um zumbi tira 2 de vida)
@export var speed: int
@export var direct_damage: int
@export var impact_damage: int
@export var distance_attack: int #distancia maxima que o dragao pode atacar com projeteis
@export var sprite_anim: AnimatedSprite2D
@export var timer_recarge: Timer 
@export var max_distance_to_target: int #distancia minima que o dragao precisa tá pra atacar com projeteis, se tiver mais perto que isso ele vai atacar com chama
@export var area_detect: Area2D

var list_anim: Array

@export var target: CharacterBody2D

enum STATES {IDLE = 1, MOVE, ATTACK}
var current_state: int
var current_life: int
var current_level: int
var can_attack: bool = true

func _ready():
	list_anim = sprite_anim.sprite_frames.get_animation_names()
	area_detect.set_shape(distance_attack)
	change_state(STATES.MOVE)
	
func change_state(_state: int) -> void:
	current_state = _state
	
func start_anim(_name: String) -> void:
	sprite_anim.play(_name)

func _physics_process(delta):
	match current_state:
		STATES.IDLE:
			idle()
		STATES.MOVE:
			move_to_target()
			
func idle() -> void:
	if target != null:
		if global_position.distance_to(target.global_position) > max_distance_to_target:
			change_state(STATES.MOVE)
	else:
		var new_target = area_detect.get_next_target(self, 'zumbi')
		
		if new_target != null:
			target = new_target
			
	if has_method('state_idle'): #isso aqui para caso seja preciso tratar o estado de parado diferente em cada dragao
		call_deferred('state_idle')
		
func move_to_target() -> void:
	if not target:
		change_state(STATES.IDLE)
		return
	
	#print(target.sprite_animated.animation, target.life)
	if has_node('Icon'):
		$Icon.global_position = target.global_position #apenas para teste
	
	var direction_to_target: Vector2 = global_position.direction_to(target.global_position)
	var distance_to_target = global_position.distance_to(target.global_position)
	
	velocity = direction_to_target.normalized() * speed
	move_and_slide()
	sprite_anim.flip_h = global_position.x > target.global_position.x
	
	if list_anim.has('move'):
		start_anim('move')

	if distance_to_target < distance_attack and distance_to_target > max_distance_to_target:
		#significa que o alvo(target) tá dentro do alcance de ataque de projeteis e longe demais pra atacar com chamas
		if has_method('long_attack'):
		 # ---> eu verifico se o dragao tem essa func porque talvez nem todos vao ter essa habilidade de atacar de longe
			call_deferred('long_attack')
			return
	
	elif distance_to_target < max_distance_to_target and target:
		#quando o alvo(target) tá perto demais, assim podendo usar o ataque de chamas
		if has_method('close_attack'):
			print('torna')
			call_deferred('close_attack')
