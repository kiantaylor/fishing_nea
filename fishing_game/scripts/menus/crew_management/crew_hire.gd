extends Node3D

var selected_crew_member
# Called when the node enters the scene tree for the first time.
func _ready():
	Chat.menu_placement()
	get_node("crew_anim").play('idle')
	generate_stock()
	stat_update()
	

var stock=[]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("build_place"):
		crew_select(CrewData.employees[randi_range(0,99)])
		
		stat_update()
func generate_stock():
	for i in range(10):
		stock.append(CrewData.crew_generate())
	refresh_stock()
func refresh_stock():
	if  get_node("ui/left/crew_list").get_child_count()>0:
		for i in get_node("ui/left/crew_list").get_children():
			i.free()
	
	for i in stock:
		var button_load=load("res://assets/screens/menus/crew_menu_button.tscn")
		var button_new=button_load.instantiate()
		button_new.item=i
		if get_node('ui/left/crew_list').get_child_count()==0:
			button_new.position=Vector2(40,150)
		else:
			button_new.position=Vector2(40,(100*get_node('ui/left/crew_list').get_child_count())+150)
		button_new.true_parent=self
		get_node("ui/left/crew_list").add_child(button_new)
	crew_select(stock[0])
func crew_select(crew_member):
	selected_crew_member=crew_member
	get_node('wall').set_surface_override_material(0,load(str("res://Textures/crew/wallpaper"+str(crew_member.bg)+".tres")))
	stat_update()
func stat_update():
	get_node('ui2').play('switch')
	var new_colour
	get_node("crew_vis").update_skin(selected_crew_member)
	var stars=selected_crew_member.get_experience()
	#('stars:  ',stars)
	get_node('ui/right/stars').update_colours(stars)
	get_node('ui/right/salary').text='salary: '+str(selected_crew_member.get_salary())
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


func _on_hire_pressed():
	if PlayerData.money>=selected_crew_member.get_salary():
		PlayerData.money-=selected_crew_member.get_salary()
		PlayerData.save_player_data()
		CrewData.employees.append(selected_crew_member)
		CrewData.save_crew()
		var count=0
		for i in stock:
			if i==selected_crew_member:
				stock.remove_at(count)
			count+=1
			
		if len(stock)>0:
			crew_select(stock[0])
			refresh_stock()
		else:
			generate_stock()
		Chat.crew_hired(selected_crew_member.get_crew_name().capitalize())
	else:
		get_node('error_box').text='not enough money'
		get_node("error_box").visible=true


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
