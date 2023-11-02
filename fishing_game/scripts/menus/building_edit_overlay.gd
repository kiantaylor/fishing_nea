extends Control
var movement=false
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
	get_node("title").text=BuildingData.selected_building.get_meta('building_type')
	if BuildingData.selected_building.get_meta('building_type') in shop_buildings:
		get_node("shop").visible=true
	else:
		get_node("shop").visible=false
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
	for i in BuildingData.build_map[BuildingData.selected_building.get_meta('building_type')]:
		if i[1]==BuildingData.selected_building.position and i[2]==BuildingData.selected_building.rotation:
			i[0]+=1
	print( BuildingData.build_map)
	


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
