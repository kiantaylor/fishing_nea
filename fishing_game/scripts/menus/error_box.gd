extends Control
var text=''

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text=text


func _on_exit_pressed():
	visible=false
