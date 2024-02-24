extends DragonBase

@onready var timer_tornado: Timer = $tornado_timer
@onready var timer_ray: Timer = $ray_timer

var tornado = null

var can_ray: bool = true

func long_attack() -> void:
	if not target or not can_ray: return
	
	var ray = preload('res://Scenes/GamePlay/ray.tscn').instantiate()
	ray.global_position = target.global_position
	ray.start()
	get_tree().root.call_deferred('add_child', ray)
	target.take_damage(target.life)
	timer_ray.start()
	
func close_attack() -> void:
	print('uepa')
	if not target or tornado != null: return
	
	
	var zumbis_in_area:Array = area_detect.get_overlapping_bodies()
	var zumbis: Array
	
	for z in zumbis_in_area:
		if z.global_position.distance_to(global_position) < max_distance_to_target:
			zumbis.append(z)
			

	if zumbis.is_empty():return
	
	var tornado_instance = preload('res://Scenes/GamePlay/tornado.tscn').instantiate()
	
	tornado_instance.global_position = global_position
	tornado_instance.zumbis = zumbis
	tornado = tornado_instance
	get_tree().root.call_deferred('add_child', tornado_instance)
	timer_tornado.start()
	

func _on_tornado_timer_timeout():
	if not tornado: return
	
	tornado.queue_free()
	tornado = null


func _on_ray_timer_timeout():
	can_ray = true
