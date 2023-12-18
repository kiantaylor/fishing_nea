extends Sprite3D
var boat

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if boat:
		if boat.get_health()<=0:
			visible=true
		else:
			visible=false
