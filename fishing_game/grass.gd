extends Marker3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if not get_node("RayCast3D").is_colliding():
		print('dying')
		queue_free()
