extends Control

var area=''
var new_voyage
var selected_fish
var screen=2
# Called when the node enters the scene tree for the first time.
func _ready():
	
	new_voyage=VoyageData.new_voyage
	get_node("left/voyage_display").voyage=new_voyage
	area_clicked('the_shallows')
	update_fish_list()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file('res://assets/testing stuff/build_test_area.tscn')

func update_fish_list():
	if get_node('right/fish_list').get_child_count()>0:
		for i in get_node('right/fish_list').get_children():
			i.free()
	var count=0
	for i in FishData.map[area].get_levels():
			if count>0:
				var button_load=load("res://assets/screens/menus/fish_button.tscn")
				var button_new=button_load.instantiate()
				button_new.item=i
				if get_node('right/fish_list').get_child_count()==0:
					button_new.position=Vector2(40,0)
				else:
					button_new.position=Vector2(40,(100*get_node('right/fish_list').get_child_count()))
				button_new.true_parent=self
				get_node("right/fish_list").add_child(button_new)
			count+=1
	fish_select(FishData.map[area].get_levels()[1])
func area_clicked(new_area):
	area=new_area
	var title=str(area).capitalize()
	if area!=get_node("left/voyage_display").voyage.get_zone():
		get_node('right/block').visible=true
	else:
		get_node('right/block').visible=false
	get_node("right/title").text=title

	update_fish_list()
func fish_select(fish):
	get_node('right/selected/title').text=fish.get_species()
	
	selected_fish=fish
	if get_node("left/voyage_display").voyage.get_populations().find(selected_fish)>-1:
		get_node('right/selected/HSlider').value=get_node("left/voyage_display").voyage.get_ratio()[get_node("left/voyage_display").voyage.get_populations().find(selected_fish)]
	else:
		get_node('right/selected/HSlider').value=0


func _on_select_zone_pressed():
	get_node("left/voyage_display").voyage.set_zone(area)
	get_node('right/block').visible=false


func _on_h_slider_value_changed(value):
	
	if get_node("left/voyage_display").voyage.get_populations().find(selected_fish)>-1:
		get_node("left/voyage_display").voyage.set_ratio(value,get_node("left/voyage_display").voyage.get_populations().find(selected_fish))
		print(get_node("left/voyage_display").voyage.get_ratio())
		
	


func _on_assign_pressed():
	if get_node("left/voyage_display").voyage.get_populations().find(selected_fish)==-1 and len(get_node("left/voyage_display").voyage.get_populations())<3:
		get_node("left/voyage_display").voyage.add_population(selected_fish,0)


func _on_remove_pressed():
	if get_node("left/voyage_display").voyage.get_populations().find(selected_fish)!=-1:
		get_node("left/voyage_display").voyage.remove_population(selected_fish)



func _on_voyage_display_set_sail():
	get_node("AnimationPlayer").play('voyage')


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
