extends Control
var playing=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible=playing
	get_node("money").text='money: '+str(PlayerData.money)
	
