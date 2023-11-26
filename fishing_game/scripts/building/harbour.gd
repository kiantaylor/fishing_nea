extends "res://scripts/building/base_building.gd"
var size_slots=16
var selected_boat
var accessing=false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('ui/right').position.x=2885
	
	
	update_boat_list()

		

	#open_access()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if accessing and Input.is_action_just_pressed('ui_cancel'):
		close_access()
	get_node("ui/left/boat_list").position.y=-get_node('ui/left/scroll').value*10
#shop menu

func open_shop():
	get_tree().change_scene_to_file('res://assets/screens/menus/boat_purchase/boat_purchase_menu.tscn')
# access menu
func open_access():
	if not BuildingData.building_open and BuildingData.editing:
		accessing=true
		get_node("ui").visible=true
		BuildingData.accessing=true
		BuildingData.close_edit()
		get_parent().menu_accessed=true
		print('opening harbour')
		get_node("access_camera").current=true
		if len(BoatData.boats)==0:
			_on_harbour_stats_pressed()
		else:
			
			update_boat_list()
			boat_selected(BoatData.boats[0])
		get_node("AnimationPlayer").play('open_ui')
func close_access():
	accessing=false
	BuildingData.accessing=false
	get_node("access_camera").current=false
	get_parent().menu_accessed=false
	get_node("ui").visible=false
	BuildingData.open_edit(self)
	

func _on_warning_timeout():
	close_access()
func update_boat_list():
	print(get_node("boats").get_child_count(),'   boats')
	if get_node("boats").get_child_count()>0:
		for j in get_node("boats").get_children():
			j.free()
			print(get_node("boats").get_child_count(),'   boats')
	if get_node("ui/left/boat_list").get_child_count()>0:
		for j in get_node("ui/left/boat_list").get_children():
			j.free()
	print(get_node("boats").get_child_count(),'   boats')
	for i in BoatData.boats:
		var button_load=load("res://assets/boats/boat_button.tscn")
		var button_new=button_load.instantiate()
		button_new.item=i
		if get_node('ui/left/boat_list').get_child_count()==0:
			button_new.position=Vector2(20,450)
		else:
			button_new.position=Vector2(20,(100*get_node('ui/left/boat_list').get_child_count())+450)
		button_new.true_parent=self
		get_node("ui/left/boat_list").add_child(button_new)
		var boat_load=load(str("res://assets/boats/"+i.vis_name))
		var boat_new=boat_load.instantiate()
		if get_node('boats').get_child_count()==0:
			boat_new.position=Vector3(0,0,1)
		else:
			boat_new.position=Vector3((2*get_node('boats').get_child_count()),0,1)
		boat_new.rotation_degrees.y=180
		boat_new.scale=Vector3(0.5,0.5,0.5)
		boat_new.boat=i
		get_node("boats").add_child(boat_new)
func boat_selected(boat_select):
	var new_colour
	var stars=boat_select.get_condition_rating()
	print('stars:  ',stars)
	get_node('ui/right/stars').update_colours(stars)
	get_node('ui/right/stars').visible=true	
	get_node("ui/right/title").visible=true
	get_node("ui/right/speed").visible=true
	get_node("ui/right/durability").visible=true
	get_node("ui/right/size").visible=true
	get_node("ui/right/small").visible=true
	get_node("ui/right/medium").visible=true
	get_node("ui/right/large").visible=true
	get_node("ui/right/upgrade").visible=true
	get_node("ui/right/rename").visible=true
	get_node("ui/right/title2").visible=false
	get_node("ui/right/level").visible=false
	get_node("ui/right/space").visible=false
	get_node("ui/right/type").visible=true
	print(boat_select.get_boat_name())
	var vis
	for i in get_node("boats").get_children():
		if i.boat==boat_select:
			vis=i
			break
	print(vis,' vis')
	vis.get_node('Camera3D').current=true
	get_node("ui/right/title").text=boat_select.get_boat_name()
	get_node("ui/right/speed/value_bar").value=boat_select.get_speed()
	get_node("ui/right/speed/crew_value").value=boat_select.get_speed()*boat_select.speed_boost

	get_node("ui/right/durability/value_bar").value=boat_select.get_durability()
	get_node("ui/right/durability/crew_value").value=boat_select.get_durability()*boat_select.durability_boost

	get_node("ui/right/small/value_bar").value=boat_select.get_small()
	get_node("ui/right/small/crew_value").value=boat_select.get_small()*boat_select.small_boost
	
	get_node("ui/right/medium/value_bar").value=boat_select.get_medium()
	get_node("ui/right/medium/crew_value").value=boat_select.get_medium()*boat_select.medium_boost
	
	get_node("ui/right/large/value_bar").value=boat_select.get_large()
	get_node("ui/right/large/crew_value").value=boat_select.get_large()*boat_select.large_boost

	get_node("ui/right/large/value_bar").max_value=100
	get_node("ui/right/medium/value_bar").max_value=100
	get_node("ui/right/small/value_bar").max_value=100
	get_node("ui/right/large/crew_value").max_value=100
	get_node("ui/right/medium/crew_value").max_value=100
	get_node("ui/right/small/crew_value").max_value=100

	get_node("ui/right/size").text='Size: '+str(boat_select.get_size())
	get_node("ui/right/type").text=boat_select.trait_name+' '+boat_select.dis_name
	selected_boat=boat_select


func _on_upgrade_pressed():
	if selected_boat:
		selected_boat.upgrade()
		boat_selected(selected_boat)


func _on_rename_pressed():
	if selected_boat:
		get_node("ui/rename_text_edit").visible=true


func _on_cancel_pressed():
	get_node("ui/rename_text_edit").text=''
	get_node("ui/rename_text_edit").visible=false


func _on_confirm_pressed():
	if selected_boat.rename(get_node("ui/rename_text_edit").text):
	
		get_node("ui/rename_text_edit").visible=false
		
		boat_selected(selected_boat)
		for i in get_node("ui/left/boat_list").get_children():
			if i.boat==selected_boat:
				i.text=get_node("ui/rename_text_edit").text
		get_node("ui/rename_text_edit").text=''
	else:
		get_node("ui/rename_text_edit").text='try again'


func _on_harbour_stats_pressed():
	get_node("access_camera").current=true
	get_node('ui/right/stars').visible=false
	get_node("ui/right/title").visible=false
	get_node("ui/right/speed").visible=false
	get_node("ui/right/durability").visible=false
	get_node("ui/right/size").visible=false
	get_node("ui/right/upgrade").visible=false
	get_node("ui/right/rename").visible=false
	get_node("ui/right/small").visible=false
	get_node("ui/right/medium").visible=false
	get_node("ui/right/large").visible=false
	get_node("ui/right/title2").visible=false
	get_node("ui/right/level").visible=true
	get_node("ui/right/type").visible=false
	get_node("ui/right/space").visible=true
	get_node("ui/right/level").text='Level '+str(level)
	get_node("ui/right/space").text='Space: '+str(2*level+14)
