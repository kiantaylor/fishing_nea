extends Control

var open=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible=open
	if Input.is_action_just_pressed('pause') and not open:
		open=true
	elif Input.is_action_just_pressed('pause') and  open:
		open=false

func save():
	BoatData.save_boats()
	CrewData.save_crew()
	BuildingData.save_buildings()
	PlayerData.save_player_data()
	Chat.add_chat('Saving...')
func _on_save_pressed():
	save()



func _on_menu_pressed():
	open=false
	save()
	get_tree().change_scene_to_file("res://assets/screens/startscreen.tscn")


func _on_desktop_pressed():
	open=false
	save()
	get_tree().quit()


func _on_exit_pressed():
	open=false


func _on_settings_pressed():
	save
	get_tree().change_scene_to_file("res://assets/screens/menus/settings.tscn")
