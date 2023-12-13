extends Button

var boat
var crew_member
signal parent_press
signal no_slot_error
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if boat.add_crew(crew_member):
		
		emit_signal('parent_press')
	else:
		emit_signal('no_slot_error')
