extends DragonBase

@onready var flames: Area2D = get_node('Flames')

var flame_damage: int = 4
			

func long_attack() -> void: #ataque de longe, de disparos de bola de fogo
	if not target or not can_attack:
		return
		
	flames.visible = false
		
	sprite_anim.flip_h = global_position.x > target.global_position.x
	print('atacando')
	
	var fire_ball_scene = preload('res://Scenes/Objects/FireDragonBall.tscn')
	var fire_ball = fire_ball_scene.instantiate()
	
	fire_ball.set_damage(direct_damage, impact_damage, self)
	fire_ball.set_bullet(Vector2(0, -5), target, 7)
	call_deferred('add_child', fire_ball)
	can_attack = false
	timer_recarge.start()
	
func close_attack() -> void: #ataque de perto (ataque das chamas para esse dragao de fogo)
	if not target: 
		flames.visible = false
		return
		
	var targets_in_flames: Array = flames.get_overlapping_bodies()
	
	if targets_in_flames.is_empty():return

	$Flames/Sprites.play('burn')
	flames.visible = true
	flames.look_at(target.global_position)

	for t in targets_in_flames:
		if t.has_method('take_damage'):
			t.take_damage(flame_damage)

func state_idle() -> void:
	var targets_in_flames: Array = flames.get_overlapping_bodies()
	
	if targets_in_flames.is_empty():
		flames.visible = false
		
	close_attack()

func _on_recarge_attack_timeout():
	can_attack = true

	
	
