extends Marker2D
var building_name=''
signal build_pressed(building)
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Button").text=building_name.capitalize()
	connect("build_pressed",get_parent().get_parent().get_parent().open_info)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	emit_signal("build_pressed",building_name)
