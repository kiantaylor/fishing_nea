extends "res://scripts/menus/item_button.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("selected",true_parent.fish_select)
	text=item.get_species()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Button").text=text
