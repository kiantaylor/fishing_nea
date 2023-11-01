extends "res://scripts/building/base_building.gd"

var accessing=false
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node('ui/right').position.x=2785
	update_boat_list()
	#open_access()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if accessing and Input.is_action_just_pressed('ui_cancel'):
		close_access()
	get_node("ui/left/boat_list").position.y=-get_node('ui/left/scroll').value*10
func open_access():
	if not BuildingData.building_open and BuildingData.editing:
		accessing=true
		get_node("ui").visible=true
		BuildingData.accessing=true
		BuildingData.close_edit()
		get_parent().menu_accessed=true
		print('opening harbour')
		get_node("access_camera").current=true
		if get_node('boats').get_child_count()==0:
			get_node("ui/warning").visible=true
			get_node('warning').start()
		else:
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
	for i in BoatData.boats:
		var button_load=load("res://assets/boats/boat_button.tscn")
		var button_new=button_load.instantiate()
		button_new.boat=i
		if get_node('ui/left/boat_list').get_child_count()==0:
			button_new.position=Vector2(40,148)
		else:
			button_new.position=Vector2(40,(50*get_node('ui/left/boat_list').get_child_count())+148)
		button_new.true_parent=self
		get_node("ui/left/boat_list").add_child(button_new)
func boat_selected(boat_select):
	print(boat_select.get_boat_name())
	get_node("ui/right/title").text=boat_select.get_boat_name()
	get_node("ui/right/speed").text='Speed: '+str(boat_select.get_speed())
	get_node("ui/right/durability").text='Durability: '+str(boat_select.get_durability())
