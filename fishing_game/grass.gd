extends Marker3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if not get_node("RayCast3D").is_colliding():
	
		queue_free()
	else: 
		if get_node("RayCast3D").get_collider().has_meta('building_type'):
			
			if get_node("RayCast3D").get_collider().get_meta('building_type')=='harbour':
				queue_free()
