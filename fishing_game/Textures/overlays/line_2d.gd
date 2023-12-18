extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('Timer').wait_time=randf_range(3.0,30.0)
	get_node('Timer').start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count=0
	for i in get_node("Path2D").get_children():
		if i.progress_ratio>=0.95:
			remove_point(count)
		else:
			points[count].x=i.global_position.x
			points[count].y=i.global_position.y
			count+=1
func add_points():
	
	var load_follow=load('res://wind_follow.tscn')
	for i in range(10):
		add_point(Vector2(0,0),i)
		var new_follow=load_follow.instantiate()
		new_follow.time_wait=0.05*i
		get_node("Path2D").add_child(new_follow)
		


func _on_timer_timeout():
	add_points()
