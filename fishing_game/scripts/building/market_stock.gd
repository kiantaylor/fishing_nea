extends Marker3D
var fish=''

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("SubViewport/Label").text=fish.capitalize()
	get_node("name_sprite").texture=get_node("SubViewport").get_texture()
