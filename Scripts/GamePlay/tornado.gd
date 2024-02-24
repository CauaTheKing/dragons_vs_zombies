extends Area2D

var speed: float = 50.0
var direction: Vector2

var zumbis: Array = []

func _ready():
	set_direction()

func _process(delta):
	if direction:
		global_translate(direction * delta * speed)
		
func set_direction() -> void:
	var target: CharacterBody2D
	
	
	if not zumbis.is_empty():
		target = zumbis.pick_random()
	
		direction = global_position.direction_to(target.global_position)
		return
	
	direction = Vector2(randi_range(-1, 1),randi_range(-1, 1))
		
		

func attacking() -> void:
	var zumbis: Array = get_overlapping_bodies()
	
	if zumbis.is_empty(): return
	
	for z in zumbis:
		z.throw()


func _on_body_entered(body):
	body.target_direction = body.global_position + Vector2(randi_range(-300, 300), randi_range(-300, 300))
	body.take_damage(3)
	body.change_state(4)


func _on_timer_change_velocity_timeout():
	set_direction()
