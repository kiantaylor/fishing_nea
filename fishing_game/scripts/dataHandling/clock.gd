extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ecotick_timeout():
	FishData.tick()
	VoyageData.tick()
	EventData.tick()


func _on_autosave_timeout():
	BoatData.save_boats()
	CrewData.save_crew()
	BuildingData.save_buildings()
	PlayerData.save_player_data()
	Chat.add_chat('Saving...')
