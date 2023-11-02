extends Node3D

var future_rotation=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('ui_right'):
		future_rotation+=0.1
	elif Input.is_action_pressed('ui_left'):
		future_rotation-=0.1
	get_node("pivot").rotation.y=lerp(get_node("pivot").rotation.y,future_rotation,delta)
