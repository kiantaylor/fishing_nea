extends "res://scripts/building/base_building.gd"
var size_slots=16
var selected_boat
var accessing=false
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('ui/right').position.x=2785
	
	PlayerData.boat_space+=size_slots
	update_boat_list()
	boat_selected(BoatData.boats[0])
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
			get_node("ui/warning").visible=true
			get_node('warning').start()
		else:
			get_node("AnimationPlayer").play('open_ui')
			update_boat_list()
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
		button_new.boat=i
		if get_node('ui/left/boat_list').get_child_count()==0:
			button_new.position=Vector2(40,148)
		else:
			button_new.position=Vector2(40,(57*get_node('ui/left/boat_list').get_child_count())+148)
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
	print(boat_select.get_boat_name())
	var vis
	for i in get_node("boats").get_children():
		if i.boat==boat_select:
			vis=i
			break
	print(vis,' vis')
	vis.get_node('Camera3D').current=true
	get_node("ui/right/title").text=boat_select.get_boat_name()
	get_node("ui/right/speed").text='Speed: '+str(boat_select.get_speed())
	get_node("ui/right/durability").text='Durability: '+str(boat_select.get_durability())
	get_node("ui/right/condition").text='Condition: '+str(boat_select.get_condition())
	get_node("ui/right/size").text='Size: '+str(boat_select.get_size())
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
