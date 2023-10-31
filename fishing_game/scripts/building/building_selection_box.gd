extends Area3D
var hover=false
signal open_edit(building)
# Called when the node enters the scene tree for the first time.
func _ready():
	connect('open_edit',BuildingData.open_edit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hover and Input.is_action_just_pressed('leftclick'):
		emit_signal('open_edit',get_parent())
	if BuildingData.selected_building==get_parent():
		get_parent().get_node('icon').visible=true
	else:
		get_parent().get_node('icon').visible=false


func _on_mouse_entered():
	hover=true


func _on_mouse_exited():
	hover=false
