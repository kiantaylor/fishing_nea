extends "res://scripts/building/base_building.gd"

var attraction_rating
# Called when the node enters the scene tree for the first time.
func _ready():
	attraction_rating=get_meta("attraction")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
