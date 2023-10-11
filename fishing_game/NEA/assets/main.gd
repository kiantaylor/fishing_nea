extends Node3D

var building=false
# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("AnimationPlayer").play('time')
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed('build_mode') and not building:
		build_mode_activate()
	elif Input.is_action_just_pressed('build_mode') and  building:
		build_mode_deactivate()
func build_mode_activate():
	building=true
	get_node("buildCamera").current=true
	get_node("cameraPivot/camera").current=false
func build_mode_deactivate():
	building=false
	get_node("buildCamera").current=false
	get_node("cameraPivot/camera").current=true
