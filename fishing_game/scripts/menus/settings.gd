extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("wind").button_pressed=PlayerData.wind
	get_node("grass").button_pressed=PlayerData.grass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_wind_toggled(button_pressed):
	PlayerData.wind=button_pressed


func _on_grass_toggled(button_pressed):
	PlayerData.grass=button_pressed


func _on_exit_button_pressed():
	PlayerData.save_player_data()
	get_tree().change_scene_to_file("res://assets/testing stuff/build_test_area.tscn")
