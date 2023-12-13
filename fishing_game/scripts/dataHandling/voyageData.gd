extends Node

var current_voyages=[]
var new_voyage
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func tick():
	for i in current_voyages:
		i.tick()
