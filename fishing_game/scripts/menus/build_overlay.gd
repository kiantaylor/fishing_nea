extends Control

signal generate_ghost(building,relocating,ghost_position,ghost_rotation)
var tab='testing'
var up=false
# Called when the node enters the scene tree for the first time.
func _ready():
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
func _on_test_building_1_pressed():
	var requirements=BuildingData.build_requirements['test_building_1']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1]:
		emit_signal('generate_ghost','test_building_1',false,Vector3(0,0,0),Vector3(0,0,0))

func _on_test_building_2_pressed():
	var requirements=BuildingData.build_requirements['test_building_2']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1]:
		emit_signal('generate_ghost','test_building_2',false,Vector3(0,0,0),Vector3(0,0,0))


func _on_pop_up_button_pressed():
	if not BuildingData.editing:
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
