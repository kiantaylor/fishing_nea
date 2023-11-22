extends Marker3D
var rotation_target=0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotate_increment=1.0
	var rotate_scale=2.0
	if Input.is_action_pressed('ui_left'):
		rotation_target-=rotate_increment
	elif Input.is_action_pressed('ui_right'):
		rotation_target+=rotate_increment
	elif Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		rotation_target-=rotate_increment/2.0
	rotation_degrees.y=lerp(rotation_degrees.y,rotation_target,delta*rotate_scale)
#	if Input.is_action_pressed("ui_down"):
#		position.z+=1
#	elif Input.is_action_pressed("ui_up"):
#		position.z-=1
#	if Input.is_action_pressed("ui_right"):
#		position.x+=1
#	elif Input.is_action_pressed("ui_left"):
#		position.x-=1
