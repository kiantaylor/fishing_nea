extends StaticBody3D
var level=1
var cam_open=false
var target_rotation=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node('pivot').rotation.y=lerp(get_node('pivot').rotation.y,target_rotation,delta*0.3)
	if cam_open and Input.is_action_pressed('ui_left'):
		target_rotation-=0.05
	elif cam_open and Input.is_action_pressed('ui_right'):
		target_rotation+=0.05
func open_access():
	print('opening placeholder')
func open_shop():
	print('opening placeholder shop')
func open_camera():
	if not cam_open:
		get_node('pivot/Camera3D').current=true
		cam_open=true
	else:
		get_node('pivot/Camera3D').current=false
		cam_open=false
	
