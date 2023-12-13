extends Button

var boat
var crew_member
signal parent_press
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	boat.remove_crew(crew_member)
	emit_signal('parent_press')
