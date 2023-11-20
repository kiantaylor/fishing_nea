extends "res://scripts/menus/item_button.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("selected",true_parent.crew_select)
	text=item.get_crew_name()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Button").text=text
