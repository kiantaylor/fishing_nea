extends "res://scripts/building/base_building.gd"
var size_slots=16
var selected_boat
var accessing=false
var bottom_open=false
var current=false
var role_current=''
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
	if selected_boat:
		if selected_boat.on_voyage:
			get_node('ui/voyage_bar').max_value=selected_boat.total_time
			get_node('ui/voyage_bar').value=selected_boat.time_left
		elif get_node('ui/voyage_bar').visible:
		
			get_node('ui/voyage_bar').visible=false
	else:
		get_node('ui/voyage_bar').visible=false
		
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
			boat_new.position=Vector3(5,-0.6,1)
		else:
			boat_new.position=Vector3((2*get_node('boats').get_child_count())+5,-0.6,1)
		boat_new.rotation_degrees.y=180
		boat_new.scale=Vector3(0.5,0.5,0.5)
		boat_new.boat=i

		
		get_node("boats").add_child(boat_new)
func boat_selected(boat_select):
	get_node('ui/voyage_bar').visible=boat_select.on_voyage
	if bottom_open:
		get_node("AnimationPlayer").play('close_bottom')
		bottom_open=false
	var new_colour
	var stars=boat_select.get_condition_rating()
	print('stars:  ',stars)
	get_node('ui/right/boat_stats/stars').update_colours(stars)
	get_node("ui/right/boat_stats").visible=true
	get_node("ui/right/harbour_stats").visible=false
	get_node("ui/right/crew_select").visible=false
	print(boat_select.get_boat_name())
	var vis
	for i in get_node("boats").get_children():
		if i.boat==boat_select:
			vis=i
			break
	print(vis,' vis')
	vis.get_node('Camera3D').current=true
	get_node("ui/right/boat_stats/title").text=boat_select.get_boat_name()
	get_node("ui/right/boat_stats/speed/value_bar").value=boat_select.get_speed()
	get_node("ui/right/boat_stats/speed/crew_value").value=boat_select.get_speed()*boat_select.speed_boost

	get_node("ui/right/boat_stats/durability/value_bar").value=boat_select.get_durability()
	get_node("ui/right/boat_stats/durability/crew_value").value=boat_select.get_durability()*boat_select.durability_boost

	get_node("ui/right/boat_stats/small/value_bar").value=boat_select.get_small()
	get_node("ui/right/boat_stats/small/crew_value").value=boat_select.get_small()*boat_select.small_boost
	
	get_node("ui/right/boat_stats/medium/value_bar").value=boat_select.get_medium()
	get_node("ui/right/boat_stats/medium/crew_value").value=boat_select.get_medium()*boat_select.medium_boost
	
	get_node("ui/right/boat_stats/large/value_bar").value=boat_select.get_large()
	get_node("ui/right/boat_stats/large/crew_value").value=boat_select.get_large()*boat_select.large_boost

	get_node("ui/right/boat_stats/large/value_bar").max_value=100
	get_node("ui/right/boat_stats/medium/value_bar").max_value=100
	get_node("ui/right/boat_stats/small/value_bar").max_value=100
	get_node("ui/right/boat_stats/large/crew_value").max_value=100
	get_node("ui/right/boat_stats/medium/crew_value").max_value=100
	get_node("ui/right/boat_stats/small/crew_value").max_value=100

	get_node("ui/right/boat_stats/size").text='Size: '+str(boat_select.get_size())
	get_node("ui/right/boat_stats/type").text=boat_select.trait_name+' '+boat_select.dis_name
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
			if i.item==selected_boat:
				i.text=get_node("ui/rename_text_edit").text
		get_node("ui/rename_text_edit").text=''
	else:
		get_node("ui/rename_text_edit").text='try again'


func _on_harbour_stats_pressed():
	if bottom_open:
		get_node("AnimationPlayer").play('close_bottom')
		bottom_open=false
	get_node("access_camera").current=true
	get_node("ui/right/boat_stats").visible=false
	get_node("ui/right/harbour_stats").visible=true
	get_node("ui/right/crew_select").visible=false
	get_node("ui/right/harbour_stats/level").text='Level '+str(level)
	get_node("ui/right/harbour_stats/space").text='Space: '+str(2*level+14)


func _on_crew_pressed():
	get_node("ui/right/crew_select/title").text=selected_boat.get_boat_name()
	get_node("ui/right/boat_stats").visible=false
	get_node("ui/right/harbour_stats").visible=false
	get_node("ui/right/crew_select").visible=true
	for i in get_node("ui/right/crew_select/tabs").get_children():
		if i.name in selected_boat.crew_slots:
			i.disabled=false
		else:
			i.disabled=true
	crew_display('skp')
	
func crew_display(role):
	role_current=role
	if get_node("ui/right/crew_select/crew_list").get_child_count()>0:
		for i in get_node('ui/right/crew_select/crew_list').get_children():
			i.free()
	
	if CrewData.employees!=[]:
		for i in CrewData.employees:
			if current:
				if i.crew_type==role and i in selected_boat.crew:
					var button_load=load("res://assets/screens/menus/crew_menu_button.tscn")
					var button_new=button_load.instantiate()
					button_new.item=i
					if get_node('ui/right/crew_select/crew_list').get_child_count()==0:
						button_new.position=Vector2(0,0)
					else:
						button_new.position=Vector2(0,(100*get_node('ui/right/crew_select/crew_list').get_child_count()))
					button_new.true_parent=self
					get_node('ui/right/crew_select/crew_list').add_child(button_new)
			else:
				if i.crew_type==role and not i.assigned:
					var button_load=load("res://assets/screens/menus/crew_menu_button.tscn")
					var button_new=button_load.instantiate()
					button_new.item=i
					if get_node('ui/right/crew_select/crew_list').get_child_count()==0:
						button_new.position=Vector2(0,0)
					else:
						button_new.position=Vector2(0,(100*get_node('ui/right/crew_select/crew_list').get_child_count()))
					button_new.true_parent=self
					get_node('ui/right/crew_select/crew_list').add_child(button_new)
func crew_select(crew_member):
	if not bottom_open:
		get_node("AnimationPlayer").play('open_bottom')
	var num=randi_range(1,3)
	get_node("crewport/wall").set_surface_override_material(0,load(str("res://Textures/crew/wallpaper"+str(crew_member.bg)+".tres")))
	get_node("crewport/crew_vis").update_skin(crew_member)
	get_node('ui/bottom/portrait').texture=get_node("crewport").get_viewport().get_texture()
	get_node('ui/bottom/stars').update_colours(crew_member.get_experience())
	get_node('ui/bottom/speed_boost/value_bar').value=crew_member.speed_effect
	get_node('ui/bottom/durability_boost/value_bar').value=crew_member.durability_effect
	get_node('ui/bottom/small_boost/value_bar').value=crew_member.small_fish_effect
	get_node('ui/bottom/medium_boost/value_bar').value=crew_member.medium_fish_effect
	get_node('ui/bottom/large_boost/value_bar').value=crew_member.large_fish_effect
	get_node('ui/bottom/morale/value_bar').value=crew_member.morale_effect
	get_node('ui/bottom/speed_boost/value_bar').max_value=100
	get_node('ui/bottom/durability_boost/value_bar').max_value=100
	get_node('ui/bottom/small_boost/value_bar').max_value=100
	get_node('ui/bottom/medium_boost/value_bar').max_value=100
	get_node('ui/bottom/large_boost/value_bar').max_value=100
	get_node('ui/bottom/morale/value_bar').max_value=100
	get_node('ui/bottom/assign').boat=selected_boat
	get_node('ui/bottom/assign').crew_member=crew_member
	get_node('ui/bottom/remove').boat=selected_boat
	get_node('ui/bottom/remove').crew_member=crew_member
	get_node('ui/bottom/title').text=crew_member.get_crew_name()

func _on_skp_pressed():
	crew_display('skp')

func _on_coo_pressed():
	crew_display('coo')


func _on_eng_pressed():
	crew_display('eng')


func _on_mte_pressed():
	crew_display('mte')


func _on_dek_pressed():
	crew_display('dek')


func _on_animation_player_animation_finished(anim_name):
	if anim_name=='open_bottom':
		bottom_open=true


func _on_current_pressed():
	current=true
	get_node('ui/bottom/assign').visible=false
	get_node('ui/bottom/remove').visible=true
	crew_display(role_current)
	


func _on_available_pressed():
	current=false
	get_node('ui/bottom/assign').visible=true
	get_node('ui/bottom/remove').visible=false
	crew_display(role_current)










func parent_press():
	crew_display(role_current)


func _on_assign_no_slot_error():
	get_node('ui/error_box').text='Slot already filled'
	get_node('ui/error_box').visible=true


func _on_voyage_pressed():
	VoyageData.new_voyage=VoyageClass.new(selected_boat,'',false)
	get_tree().change_scene_to_file('res://assets/screens/menus/voyage_menu.tscn')





func _on_back_pressed():
	get_node("ui/right/boat_stats").visible=true
	get_node("ui/right/harbour_stats").visible=false
	get_node("ui/right/crew_select").visible=false


func _on_exit_pressed():
	if accessing:
		close_access()
