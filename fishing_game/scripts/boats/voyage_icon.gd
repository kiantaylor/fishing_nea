extends Sprite3D

var boat
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boat:
#		if boat==BoatData.boats[0]:
#			print('yes')
		visible=boat.on_voyage
		get_node('viewport/Label').text=str(boat.time_left,'/',boat.total_time)
		get_node("viewport/TextureProgressBar").max_value=int(boat.total_time)
		get_node("viewport/TextureProgressBar").value=int(boat.time_left)
		texture=get_node("viewport").get_texture()
