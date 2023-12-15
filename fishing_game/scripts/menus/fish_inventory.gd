extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_fish()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("left/fish_list").position.y=244-get_node("left/HScrollBar").value


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")

func update_fish():
	var load_button=load('res://assets/screens/menus/fish_inventory_button.tscn')
	if get_node('left/fish_list').get_child_count()>0:
		for i in get_node("left/fish_list").get_children():
			i.free()
	for i in FishData.inventory:
		var new_button=load_button.instantiate()
		new_button.true_parent=self
		new_button.item=i
		new_button.position.y=89*get_node('left/fish_list').get_child_count()
		get_node("left/fish_list").add_child(new_button)
	if len(FishData.inventory)>0:
		fish_select(FishData.inventory.keys()[0])
		
func fish_select(fish):
	print(fish)
	get_node('right/count').text='Count : '+str(FishData.inventory[fish])
	get_node('right/price').text='Price per Unit : '+str(FishData.fish_stats[fish][5])
	get_node('right/total').text='Total Worth : '+str(FishData.fish_stats[fish][5]*FishData.inventory[fish])
	get_node('right/location').text='Location : '+str(FishData.fish_stats[fish][2])
	get_node('right/max_depth').text='Max Depth : '+str(FishData.fish_stats[fish][0][1])
	get_node('right/min_depth').text='Min Depth : '+str(FishData.fish_stats[fish][0][0])
	if FishData.fish_stats[fish][1]==1:
		get_node('right/size').text='Small Fish'
	elif FishData.fish_stats[fish][1]==2:
		get_node('right/size').text='Medium Fish'
	elif FishData.fish_stats[fish][1]==3:
		get_node('right/size').text='Large Fish'
		
