extends "res://scripts/menus/item_button.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("selected",true_parent.boat_selected)
	text=item.get_boat_name()


# Called every frame. 'delta' is the elapsed time since the previous frame.

