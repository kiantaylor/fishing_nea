extends PathFollow2D

var started=false
var time_wait=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("_Timer_241762").wait_time=time_wait
	get_node("_Timer_241762").start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started:
		if progress_ratio<0.95:
			progress_ratio=lerp(progress_ratio,1.0,delta*1.2)
		else:
			
			queue_free()


func _on__timer_241762_timeout():
	started=true
