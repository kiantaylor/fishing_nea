extends "res://scripts/building/base_building.gd"


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
	get_tree().change_scene_to_file('res://assets/screens/menus/crew_viewport.tscn')
func open_shop():
	get_tree().change_scene_to_file('res://assets/screens/menus/crew_hire.tscn')
