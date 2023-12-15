extends "res://scripts/building/base_building.gd"
var stock=[]
var accessing=false
var slot_open
# Called when the node enters the scene tree for the first time.
func _ready():
	update_fish()
	
	open_slot(0)
func _process(delta):
	get_node('pivot').rotation.y=lerp(get_node('pivot').rotation.y,target_rotation,delta*0.3)
	if cam_open and Input.is_action_pressed('ui_left'):
		target_rotation-=0.05
	elif cam_open and Input.is_action_pressed('ui_right'):
		target_rotation+=0.05
	get_node('ui/fish_list').position.y=229-get_node('ui/VScrollBar').value
# Called every frame. 'delta' is the elapsed time since the previous frame.
func open_access():
	update_fish()
	if not BuildingData.building_open and BuildingData.editing:
		accessing=true
		get_node("ui").visible=true
		BuildingData.accessing=true
		BuildingData.close_edit()
		BuildingData.close_info()
		get_parent().menu_accessed=true
		print('opening market')
		get_node("access_camera").current=true
func close_access():
	accessing=false
	BuildingData.accessing=false
	get_node("access_camera").current=false
	get_parent().menu_accessed=false
	get_node("ui").visible=false
	BuildingData.open_edit(self)

		
func update_fish():
	var load_button=load('res://assets/screens/menus/fish_inventory_button.tscn')
	if get_node('ui/fish_list').get_child_count()>0:
		for i in get_node("ui/fish_list").get_children():
			i.free()
	for i in FishData.inventory:
		var new_button=load_button.instantiate()
		new_button.true_parent=self
		new_button.item=i
		new_button.position.y=89*get_node('ui/fish_list').get_child_count()
		get_node("ui/fish_list").add_child(new_button)

func _on_exit_pressed():
	close_access()

func open_slot(slot):
	
	var count=0
	for i in stock:
		get_node('stock').get_children()[count].fish=i
		count+=1
	slot_open=slot
	if len(stock)>slot:
		get_node('ui/title').text=stock[slot].capitalize()
		get_node('ui/price').text='Price per Unit : '+str(FishData.fish_stats[stock[slot]][5])
		get_node('ui/stock').text='Stock Available : '+str(FishData.inventory[stock[slot]])
	else:
		get_node('ui/title').text='Empty'
		get_node('ui/price').text='Price per Unit : N/A'
		get_node('ui/stock').text='Stock Available : N/A'
func _on_slot_1_pressed():
	open_slot(0)


func _on_slot_2_pressed():
	open_slot(1)


func _on_slot_3_pressed():
	open_slot(2)



	
func fish_select(fish):
	if len(stock)<slot_open+1:
		stock.append(fish)
	else:
		stock[slot_open]=fish
	
	for i in BuildingData.build_map[get_meta("building_type")]:
		if i[1]==position:
			i[3]=stock
	open_slot(slot_open)


func _on_timer_timeout():
	for i in stock:
		FishData.inventory[i]-=1
		PlayerData.money+=FishData.fish_stats[i][5]
