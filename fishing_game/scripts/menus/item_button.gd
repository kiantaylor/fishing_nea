extends Marker2D
signal selected(item)
var item
var text=''
var true_parent
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("selected",true_parent.selected)
	#text=item.get_boat_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Button").text=text


func _on_button_pressed():
	emit_signal("selected",item)
