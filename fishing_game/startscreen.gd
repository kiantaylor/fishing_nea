extends Node3D
var started=false
var open=false
var hover
var load_hover
var quit_hover
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimationPlayer").play('startup')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and started and not open:
		get_node("AnimationPlayer").play('open')
	if Input.is_action_just_pressed('leftclick') and hover:
		var file3 = FileAccess.open('user://player_data.dat',FileAccess.WRITE)
		var stat_dict={
			'money':10000,
			'lvl':1,
			'boat_space':0,
			'boat_space_used':0,
			'grass':true,
			'wind':true
		}
		file3.store_var(stat_dict)
		file3.flush()
		file3.close()
		var file=FileAccess.open("user://boat_data.dat", FileAccess.WRITE)
		file.store_var({},true)
		file.flush()
		var file4=FileAccess.open("user://crew_data.dat", FileAccess.WRITE)
		file4.store_var({},true)
		file4.flush()
		var file2=FileAccess.open("user://building_data.dat", FileAccess.WRITE)
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
		file2.store_var(build_map)
		file2.flush()
		get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
	elif Input.is_action_just_pressed('leftclick') and load_hover:
		#('loading')
		get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
	elif Input.is_action_just_pressed('leftclick') and quit_hover:
		get_tree().quit()
func _on_animation_player_animation_finished(anim_name):
	if anim_name=='startup':
		started=true
	elif anim_name=='open':
		open=true


func _on_start_button_mouse_entered():
	hover=true
	get_node('new').modulate=Color('ffff00')


func _on_start_button_mouse_exited():
	hover=false
	get_node('new').modulate=Color('ffffff')


func _on_load_button_mouse_entered():
	load_hover=true
	get_node('load').modulate=Color('ffff00')


func _on_load_button_mouse_exited():
	load_hover=false
	get_node('load').modulate=Color('ffffff')


func _on_quit_button_mouse_entered():
	quit_hover=true
	get_node('quit').modulate=Color('ffff00')


func _on_quit_button_mouse_exited():
	quit_hover=false
	get_node('quit').modulate=Color('ffffff')
