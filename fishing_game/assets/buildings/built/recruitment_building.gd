extends "res://scripts/building/base_building.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_access():
	get_tree().change_scene_to_file('res://assets/screens/menus/crew_viewport.tscn')
