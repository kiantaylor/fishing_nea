extends Node

class_name Population
var max=0.0
var mass=0.0
var foodLimit=0.0
var depth=0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	max=mass*foodLimit
