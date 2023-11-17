extends Marker2D
var building=''
signal build(building)
signal close
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("build",get_parent().build)
	connect("close",get_parent().close_info)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func reload_labels():
	get_node("title").text=building
	get_node("price").text='Price: '+str(BuildingData.build_requirements[building][0])
	get_node("limit").text='Max builds: '+str(len(BuildingData.build_map[building]))+'/'+str(BuildingData.build_requirements[building][2])
	get_node("level").text='Level unlocked: '+str(BuildingData.build_requirements[building][1])


func _on_button_pressed():
	emit_signal("build",building)


func _on_close_pressed():
	emit_signal('close')
