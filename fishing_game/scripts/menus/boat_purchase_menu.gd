extends Control

var stock=[]
var price=0
var selected_boat
var gold=Color('ffe15f')
var silver=Color('bcd2eb')
var bronze=Color('a5a562')
var white=Color('ffffff')
# Called when the node enters the scene tree for the first time.
func _ready():
	stock_gen()
	refresh_stock()
	boat_selected(stock[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("left/boat_list").position.y=-get_node('left/scroll').value*10
	get_node("left/money").text='Money:  '+str(PlayerData.money)
func stock_gen():
	for i in range(10):
		stock.append(BoatData.boatGenerate())
	#	stock[i].add_crew(CrewData.crew_generate())
func refresh_stock():
	if  get_node("left/boat_list").get_child_count()>0:
		for i in get_node("left/boat_list").get_children():
			i.free()
	for i in stock:
		var button_load=load("res://assets/boats/boat_button.tscn")
		var button_new=button_load.instantiate()
		button_new.boat=i
		if get_node('left/boat_list').get_child_count()==0:
			button_new.position=Vector2(40,250)
		else:
			button_new.position=Vector2(40,(100*get_node('left/boat_list').get_child_count())+250)
		button_new.true_parent=self
		get_node("left/boat_list").add_child(button_new)
func boat_selected(boat_select):
	var new_colour
	var stars=boat_select.get_condition_rating()
	print('stars:  ',stars)
	if stars<=5:
		new_colour=bronze
	elif stars<=10:
		stars-=5
		new_colour=silver
	else:
		stars-=10
		new_colour=gold
	for i in get_node('right/stars').get_children():
		if stars>0:
			i.modulate=new_colour
		else:
			i.modulate=white
		stars-=1
	if get_node("3dSpace/pivot").get_child_count()>0:
		get_node("3dSpace/pivot").get_child(0).queue_free()
	var boat_load=load(str("res://assets/boats/"+boat_select.vis_name))
	var boat_new=boat_load.instantiate()
	get_node("3dSpace/pivot").add_child(boat_new)
	get_node('3dSpace').future_rotation=deg_to_rad(-90.0)
	get_node('3dSpace/pivot').rotation_degrees.y=-90.0
	get_node("right/title").text=boat_select.get_boat_name()
	get_node("right/type").text=boat_select.trait_name+' '+boat_select.dis_name
	get_node("right/speed/value_bar").value=boat_select.get_speed()
	get_node("right/durability/value_bar").value=boat_select.get_durability()
	get_node("right/small/value_bar").value=boat_select.get_small()
	get_node("right/medium/value_bar").value=boat_select.get_medium()
	get_node("right/large/value_bar").value=boat_select.get_large()
	get_node("right/large/value_bar").max_value=100
	get_node("right/medium/value_bar").max_value=100
	get_node("right/small/value_bar").max_value=100
	
	get_node("right/size").text='Size: '+str(boat_select.get_size())
	price=boat_select.price
	get_node("right/price").text='Price: '+str(price)
	print('hi')
	selected_boat=boat_select


func _on_purchase_pressed():
	print('space  ',PlayerData.boat_space)
	if PlayerData.money>=price:
		if PlayerData.boat_space_used+selected_boat.get_size()<=PlayerData.boat_space:
			print('space  ',PlayerData.boat_space,'  total space ',PlayerData.boat_space_used+selected_boat.get_size(),' current used  ',PlayerData.boat_space_used)
			BoatData.boats.append(selected_boat)
			PlayerData.boat_space_used+=selected_boat.get_size()
			PlayerData.money-=price
			var count=0
			for i in stock:
				if i==selected_boat:
					stock.remove_at(count)
				count+=1
			refresh_stock()		
			if len(stock)>0:
				boat_selected(stock[0])
		else:
			print('space  ',PlayerData.boat_space)
			get_node('error_box').text='No space available'
			get_node('error_box').visible=true
	else:
		print('money')
		get_node('error_box').text='Not enough money'
		get_node('error_box').visible=true
		
		#get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
