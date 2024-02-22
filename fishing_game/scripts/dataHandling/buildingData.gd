extends Node

var selected_building
var editing=false
var building_open=false
var build_edit_overlay
var build_overlay
var position_backup
var ghost_present
var building_camera=false
var accessing=false
#attribute order : price, level , max number
var build_requirements={
	'test_building_1':[1000,1,5],
	'test_building_2':[1700,2,3],
	'harbour':[2000,1,1],
	'anchor':[100,1,1],
	'job_centre':[1500,1,1],
	'voyage_building':[800,1,1],
	'light_house':[2000,1,1],
	'palm_tree':[75,2,100],
	'market':[600,1,5],
	'fish_safe':[1000,1,1],
	'ammonite':[2500,2,1],
	'cheese':[7500,4,1]
}

var build_map={
	'test_building_1':[],
	'test_building_2':[],
	'harbour':[],
	'anchor':[],
	'palm_tree':[],
	'job_centre':[],
	'voyage_building':[],
	'market':[],
	'fish_safe':[],
	'light_house':[[1,Vector3(3.76,12.7,0),Vector3(0,-90,0)]],
	'ammonite':[],
	'cheese':[]
}

signal open_edit_menu
signal open_building_camera
# Called when the node enters the scene tree for the first time.
func _ready():
	print('<building data initiated>')
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_cancel') and building_camera:
		building_camera=false
		emit_signal('open_building_camera')
	if accessing:
		building_camera=false
	if Input.is_action_just_pressed('level_boost'):
		save_buildings()
func open_edit(building):
	if not building_open and not accessing and (selected_building!=building or (selected_building==building and not editing)):
		connect('open_edit_menu',build_edit_overlay.open)
		editing=true
		selected_building=building
		#(selected_building.get_meta('building_type'))
		emit_signal('open_edit_menu')
	elif not building_open and not accessing and  selected_building==building and  editing:
		var conns=get_signal_connection_list('open_building_camera')
		for i in conns:
			disconnect('open_building_camera',i.callable)
		connect('open_building_camera',building.open_camera)
		emit_signal('open_building_camera')
		building_camera=true
func close_edit():
	editing=false
	build_edit_overlay.get_node("AnimationPlayer").play('close')
func close_info():
	build_overlay.close_info()
func load_buildings():
	var file = FileAccess.open("user://building_data.dat", FileAccess.READ)
	
	build_map=file.get_var()
		
func save_buildings():
	var file = FileAccess.open("user://building_data.dat", FileAccess.WRITE)
	
	file.store_var(build_map)
	file.flush()
