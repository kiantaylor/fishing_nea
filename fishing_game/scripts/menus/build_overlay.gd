extends Control

signal generate_ghost(building,relocating,ghost_position,ghost_rotation)
var tab='testing'
var up=false
var button_map={
	'testing':['harbour','job_centre','fish_safe'],
	'decor':['anchor','palm_tree'],
	'selling':['market']
}
# Called when the node enters the scene tree for the first time.
func _ready():
	up=false
	position=Vector2(0,1398)
	build_button_update()
	tab_reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	get_node("scrolled").position.x=-get_node('scroll_bar').value
	if Input.is_action_just_pressed("build_menu"):
		_on_pop_up_button_pressed()


func build_button_update():
	for i in get_node("scrolled").get_children():
		if i.get_child_count()>0:
			for n in i.get_children():
				n.free()
		print(i.name)
		for j in button_map[i.name]:
			print(j)
			var button_load=load("res://assets/buildings/build_button.tscn")
			var button_new=button_load.instantiate()
			button_new.building_name=j
			var x_drift=(i.get_child_count()*130)+90
			button_new.position=Vector2(x_drift,0)
			i.add_child(button_new)
func tab_reset():
	for i in get_node("scrolled").get_children():
		if i.name==tab:
			i.visible=true
		else:
			i.visible=false
func _on_testing_pressed():
	tab='testing'
	tab_reset()


func _on_boats_pressed():
	tab='boats'
	tab_reset()
func _on_decor_pressed():
	tab='decor'
	tab_reset()




func _on_build_camera_check_toggled(button_pressed):
	get_parent().build_camera=button_pressed


func _on_pop_up_button_pressed():
	if not BuildingData.editing and not BuildingData.accessing:
		if up:
			get_node("AnimationPlayer").play('close')
			up=false
		else:
			get_node("AnimationPlayer").play('pop_up')
			BuildingData.building_open=true
			up=true


func _on_animation_player_animation_finished(anim_name):
	if anim_name=='close':
		BuildingData.building_open=false
func _on_test_building_1_pressed():
	build('test_building_1')

func _on_test_building_2_pressed():
	build('test_building_2')


func _on_harbour_pressed():
	build('harbour')


func _on_anchor_pressed():
	build('anchor')
func open_info(building):
	get_node("info_box").building=building
	get_node('info_box').reload_labels()
	get_node("AnimationPlayer").play('info_open')
func info_refresh():
	get_node('info_box').reload_labels()
func build(building):
	
	var requirements=BuildingData.build_requirements[building]
	var map_segment=BuildingData.build_map[building]
	if PlayerData.lvl>=requirements[1]:
		if PlayerData.money>=requirements[0]:
			if len(map_segment)<requirements[2]:
				emit_signal('generate_ghost',building,false,Vector3(0,0,0),Vector3(0,0,0))
			else:
				get_node("error_box").text='Reached build limit for this building'
				get_node("error_box").visible=true
		else:
			get_node("error_box").text='You do not have enough money for this'
			get_node("error_box").visible=true
	else:
		get_node("error_box").text='You have not unlocked this yet'
		get_node("error_box").visible=true
		
func close_info():
	get_node("AnimationPlayer").play_backwards('info_open')



func _on_selling_pressed():
	tab='selling'
	tab_reset()
