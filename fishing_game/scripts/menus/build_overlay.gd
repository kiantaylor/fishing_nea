extends Control

signal generate_ghost(building,relocating,ghost_position,ghost_rotation)
var tab='testing'
var up=false
# Called when the node enters the scene tree for the first time.
func _ready():
	up=false
	position=Vector2(0,1398)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	get_node("scrolled").position.x=-get_node('scroll_bar').value
	if Input.is_action_just_pressed("build_menu"):
		_on_pop_up_button_pressed()



func tab_reset():
	for i in get_node("scrolled").get_children():
		if i.name==tab:
			i.visible=true
		else:
			i.visible=false
func _on_testing_pressed():
	tab='testing'
	tab_reset()


func _on_boats_pressed():
	tab='boats'
	tab_reset()





func _on_build_camera_check_toggled(button_pressed):
	get_parent().build_camera=button_pressed


func _on_pop_up_button_pressed():
	if not BuildingData.editing and not BuildingData.accessing:
		if up:
			get_node("AnimationPlayer").play('close')
			up=false
		else:
			get_node("AnimationPlayer").play('pop_up')
			BuildingData.building_open=true
			up=true


func _on_animation_player_animation_finished(anim_name):
	if anim_name=='close':
		BuildingData.building_open=false
func _on_test_building_1_pressed():
	var requirements=BuildingData.build_requirements['test_building_1']
	var map_segment=BuildingData.build_map['test_building_1']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1] and len(map_segment)<requirements[2]:
		emit_signal('generate_ghost','test_building_1',false,Vector3(0,0,0),Vector3(0,0,0))

func _on_test_building_2_pressed():
	var requirements=BuildingData.build_requirements['test_building_2']
	var map_segment=BuildingData.build_map['test_building_2']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1] and len(map_segment)<requirements[2]:
		emit_signal('generate_ghost','test_building_2',false,Vector3(0,0,0),Vector3(0,0,0))


func _on_harbour_pressed():
	var requirements=BuildingData.build_requirements['harbour']
	var map_segment=BuildingData.build_map['harbour']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1] and len(map_segment)<requirements[2]:
		emit_signal('generate_ghost','harbour',false,Vector3(0,0,0),Vector3(0,0,0))


func _on_anchor_pressed():
	var requirements=BuildingData.build_requirements['anchor']
	var map_segment=BuildingData.build_map['anchor']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1] and len(map_segment)<requirements[2]:
		emit_signal('generate_ghost','anchor',false,Vector3(0,0,0),Vector3(0,0,0))
