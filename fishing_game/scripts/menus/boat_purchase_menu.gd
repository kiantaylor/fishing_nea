extends Control

var stock=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	refresh_stock()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh_stock():
	for i in get_node("boats").get_children():
		i.boat=BoatData.boatGenerate()