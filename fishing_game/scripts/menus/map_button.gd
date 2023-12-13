extends Area2D
var hover=false
signal area_clicked(area)
# Called when the node enters the scene tree for the first time.
func _ready():
	area_clicked.connect(get_parent().area_clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('leftclick') and hover:
		emit_signal("area_clicked",name)


func _on_mouse_entered():
	#get_node("ColorRect").visible=true
	hover=true


func _on_mouse_exited():
	get_node("ColorRect").visible=false
	hover=false
