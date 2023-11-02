extends Control

var stock=[]
var price=0
var selected_boat
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
func refresh_stock():
	if  get_node("left/boat_list").get_child_count()>0:
		for i in get_node("left/boat_list").get_children():
			i.free()
	for i in stock:
		var button_load=load("res://assets/boats/boat_button.tscn")
		var button_new=button_load.instantiate()
		button_new.boat=i
		if get_node('left/boat_list').get_child_count()==0:
			button_new.position=Vector2(40,150)
		else:
			button_new.position=Vector2(40,(90*get_node('left/boat_list').get_child_count())+150)
		button_new.true_parent=self
		get_node("left/boat_list").add_child(button_new)
func boat_selected(boat_select):
	if get_node("3dSpace/pivot").get_child_count()>0:
		get_node("3dSpace/pivot").get_child(0).queue_free()
	var boat_load=load(str("res://assets/boats/"+boat_select.vis_name))
	var boat_new=boat_load.instantiate()
	get_node("3dSpace/pivot").add_child(boat_new)
	get_node('3dSpace').future_rotation=deg_to_rad(-90.0)
	get_node('3dSpace/pivot').rotation_degrees.y=-90.0
	get_node("right/title").text=boat_select.get_boat_name()
	get_node("right/type").text=boat_select.trait_name+' '+boat_select.dis_name
	get_node("right/speed").text='Speed: '+str(boat_select.get_speed())
	get_node("right/durability").text='Durability: '+str(boat_select.get_durability())
	get_node("right/condition").text='Condition: '+str(boat_select.get_condition())
	get_node("right/size").text='Size: '+str(boat_select.get_size())
	price=boat_select.price
	get_node("right/price").text='Price: '+str(price)
	print('hi')
	selected_boat=boat_select


func _on_purchase_pressed():
	if PlayerData.money>=price:
		BoatData.boats.append(selected_boat)
		PlayerData.money-=price
		var count=0
		for i in stock:
			if i==selected_boat:
				stock.remove_at(count)
			count+=1
		refresh_stock()		
		if len(stock)>0:
			boat_selected(stock[0])
		
		#get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")


func _on_exit_pressed():
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
