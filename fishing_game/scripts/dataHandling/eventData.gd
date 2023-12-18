extends Node

var event_types={
	'storm':[],
	'bounty':[]
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func event_generate():
	
	var areas=FishData.map.keys()
	var area=areas.pick_random()
	var strength=randi_range(1,10)
	FishData.map[area].storm(strength)
	for i in VoyageData.current_voyages:
		if i.get_zone()==area:
			if i.get_boat().damage(strength*FishData.map[area].storm_rating):
				EventBox.text='Storm in '+area.capitalize()+' boats forced to return empty handed.'
				EventBox.visible=true
				i.storm_hit(true)
				
			else:
				EventBox.text='Storm in '+area.capitalize()+' boats suffered losses.'
				EventBox.visible=true
				i.storm_hit(false)
	
	
	
func tick():
	var chance=randi_range(1,20)
	if chance==1:
		event_generate()
