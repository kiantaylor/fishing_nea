extends Node

var selected_building
var editing=false
var building_open=false
var build_edit_overlay
var position_backup
var ghost_present
var accessing=false
#attribute order : price, level , max number
var build_requirements={
	'test_building_1':[1000,1,5],
	'test_building_2':[1700,2,3],
	'harbour':[0,1,1]
}

var build_map={
	'test_building_1':[],
	'test_building_2':[],
	'harbour':[]
}

signal open_edit_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_edit(building):
	if not building_open and not accessing and (selected_building!=building or (selected_building==building and not editing)):
		connect('open_edit_menu',build_edit_overlay.open)
		editing=true
		selected_building=building
		print(selected_building.get_meta('building_type'))
		emit_signal('open_edit_menu')
func close_edit():
	editing=false
	build_edit_overlay.get_node("AnimationPlayer").play('close')
