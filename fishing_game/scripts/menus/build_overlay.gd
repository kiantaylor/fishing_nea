extends Control

signal generate_ghost(building)
var tab='testing'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	get_node("scrolled").position.x=-get_node('scroll_bar').value
	




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
		emit_signal('generate_ghost','test_building_1')

func _on_test_building_2_pressed():
	var requirements=BuildingData.build_requirements['test_building_2']
	if PlayerData.money>=requirements[0] and PlayerData.lvl>=requirements[1]:
		emit_signal('generate_ghost','test_building_2')
