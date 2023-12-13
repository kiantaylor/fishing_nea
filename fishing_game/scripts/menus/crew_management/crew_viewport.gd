extends Node3D

var selected_crew_member
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("crew_anim").play('idle')
	
	
	refresh_stock()
	stat_update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("build_place"):
		crew_select(CrewData.employees[randi_range(0,99)])
		stat_update()
func refresh_stock():
	
	if  get_node("ui/left/crew_list").get_child_count()>0:
		for i in get_node("ui/left/crew_list").get_children():
			i.free()
	if CrewData.employees!=[]:
		for i in CrewData.employees:
			var button_load=load("res://assets/screens/menus/crew_menu_button.tscn")
			var button_new=button_load.instantiate()
			button_new.item=i
			if get_node('ui/left/crew_list').get_child_count()==0:
				button_new.position=Vector2(40,250)
			else:
				button_new.position=Vector2(40,(100*get_node('ui/left/crew_list').get_child_count())+250)
			button_new.true_parent=self
			get_node("ui/left/crew_list").add_child(button_new)
		
		crew_select(CrewData.employees[0])
func crew_select(crew_member):
	selected_crew_member=crew_member
	get_node('wall').set_surface_override_material(0,load(str("res://Textures/crew/wallpaper"+str(crew_member.bg)+".tres")))
	stat_update()
func stat_update():
	if CrewData.employees!=[]:
		get_node('ui2').play('switch')
		var new_colour
		get_node("crew_vis").update_skin(selected_crew_member)
		var stars=selected_crew_member.get_experience()
		print('stars:  ',stars)
		get_node('ui/right/stars').update_colours(stars)
		get_node('ui/right/title').text=selected_crew_member.get_crew_name()
		get_node('ui/right/type').text=selected_crew_member.get_type_name()
		get_node('ui/right/durability/value_bar').max_value=100
		get_node('ui/right/speed/value_bar').max_value=100
		get_node('ui/right/small/value_bar').max_value=100
		get_node('ui/right/medium/value_bar').max_value=100
		get_node('ui/right/large/value_bar').max_value=100
		get_node('ui/right/morale/value_bar').max_value=100
		get_node('ui/right/speed/value_bar').value=selected_crew_member.speed_effect
		get_node('ui/right/durability/value_bar').value=selected_crew_member.durability_effect
		get_node('ui/right/small/value_bar').value=selected_crew_member.small_fish_effect
		get_node('ui/right/medium/value_bar').value=selected_crew_member.medium_fish_effect
		get_node('ui/right/large/value_bar').value=selected_crew_member.large_fish_effect
		get_node('ui/right/morale/value_bar').value=selected_crew_member.morale_effect


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
