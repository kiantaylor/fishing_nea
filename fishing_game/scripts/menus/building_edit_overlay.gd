extends Control
var movement=false
var upgrade_cost=0
signal generate_ghost(building,relocating,ghost_position,ghost_rotation)
var shop_buildings=[
	'harbour'
]
# Called when the node enters the scene tree for the first time.
func _ready():
	BuildingData.build_edit_overlay=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('ui_cancel') and BuildingData.editing:
		get_node("AnimationPlayer").play('close')
		
		
func open():
	upgrade_cost=int(BuildingData.selected_building.level*0.5*BuildingData.build_requirements[BuildingData.selected_building.get_meta('building_type')][0])
	get_node("title").text=BuildingData.selected_building.get_meta('building_type')
	if BuildingData.selected_building.get_meta('building_type') in shop_buildings:
		get_node("shop").visible=true
	else:
		get_node("shop").visible=false
	get_node('upgrade').text='Upgrade costs: '+str(upgrade_cost)
	get_node("AnimationPlayer").play('open')
	



func _on_animation_player_animation_finished(anim_name):
	if anim_name=='close':
		BuildingData.selected_building=null
		BuildingData.editing=false


func _on_demolish_pressed():
	if BuildingData.editing:
		var count=0
		for i in BuildingData.build_map[BuildingData.selected_building.get_meta('building_type')]:
			if i[1]==BuildingData.selected_building.position and i[2]==BuildingData.selected_building.rotation:
				BuildingData.build_map[BuildingData.selected_building.get_meta('building_type')].remove_at(count)
			count+=1
		print( BuildingData.build_map)
		BuildingData.selected_building.queue_free()
		get_node("AnimationPlayer").play('close')


func _on_upgrade_pressed():
	if PlayerData.money>=upgrade_cost:
		for i in BuildingData.build_map[BuildingData.selected_building.get_meta('building_type')]:
			if i[1]==BuildingData.selected_building.position and i[2]==BuildingData.selected_building.rotation:
				i[0]+=1
		BuildingData.selected_building.level+=1
		print( BuildingData.build_map)
		PlayerData.money-=upgrade_cost
		upgrade_cost=int(BuildingData.selected_building.level*0.5*BuildingData.build_requirements[BuildingData.selected_building.get_meta('building_type')][0])
		get_node('upgrade').text='Upgrade costs: '+str(upgrade_cost)
		
	else:
		get_node("error_box").text='Not enough money'
		get_node("error_box").visible=true
	


func _on_movement_pressed():
	if not movement:
		movement=true
		var backup
		for i in BuildingData.build_map[BuildingData.selected_building.get_meta('building_type')]:
			if i[1]==BuildingData.selected_building.position and i[2]==BuildingData.selected_building.rotation:
				backup=i
		BuildingData.position_backup=backup
		BuildingData.selected_building.queue_free()
		emit_signal("generate_ghost",BuildingData.selected_building.get_meta('building_type'),true,BuildingData.selected_building.position,BuildingData.selected_building.rotation)
		print(backup)


func _on_access_pressed():
	BuildingData.selected_building.open_access()


func _on_shop_pressed():
	BuildingData.editing=false
	BuildingData.selected_building.open_shop()
