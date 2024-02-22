extends Node

# order of attributes: size,speed,durability,crewslots,base price,small, medium, large>
var type_dictionary={
	'bt1':[3,5.0,8.0,['skp','dek'],650,0.0,15.0,0.0],
	'bt2':[6,2.0,12.0,['skp','mte','eng','dek'],1100,30.0,0.0,0.0]
}
var name_starts=[
	'Golden',
	'Blue',
	'Red',
	'Yellow',
	'Green',
	'Purple',
	'Orange',
	'Pink',
	'White',
	'Black',
	'Grey',
	'Silver',
	'Bronze',
	'Brown',
	'Rainbow',
	'Indigo',
	'Violet',
	'Dying',
	'Crying',
	'Silent',
	'Howling',
	'Jolly',
	'Flying',
	'Slippery',
	'Pair of',
	'Shining',
	'Storm',
	'Chasing',
	'Glorious',
	'Brilliant',
	'Rotting',
	'French',
	'Welsh',
	'Sinking',
	'Millenium',
	'Rogue',
	'Wet',
	'Slippery',
	'Electric',
	'Cornish',
	'Drunken',
	'Hopeful',
	'Curious',
	'Little',
	'Brave',
	'Adventurous',
	'Speckled',
	'Pickled',
	'Leafy',
	'Fishy',
	"Neptune's"
]
var name_ends=[
	'Dutchman',
	'Tuna',
	'Sardine',
	'Bean',
	'Pearl',
	'Swordfish',
	'Hedge',
	'Pollock',
	'Carp',
	'Salmon',
	'Mackeral',
	'Rainbow',
	'Seagull',
	'Treasure',
	'Barnacle',
	'Falcon',
	'Chaser',
	'Ghost',
	'Phantom',
	'Weasel',
	'Titanic',
	'Roger',
	'Eel',
	'Badger',
	'Fox',
	'Toad',
	'Bat',
	'Penguin',
	'Shark',
	'Turtle',
	'Pirate',
	'Pasty',
	'Pint',
	'Snake',
	'Crab',
	'Lobster',
	'Limpet',
	'Flower',
	'Ruby',
	'Diamond',
	'Whale',
	'Beacon',
	'Wave',
	'Squid',
	'Parrot',
	'Bobcat',
	'Ray',
	'Dolphin',
	'Endeavor',
	'Chimera',
	'Mary',
	'Steve',
	'Dereck',
	'Adventure',
	'Rocket',
	'Jo',
	'Kevin',
	'Peggy',
	
	
	
]
var boats=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	#(load('res://scripts/dataHandling/boat_class.gd').get_property_list())
	#('^')
	#(load('res://scripts/dataHandling/boat_class.gd').get('RefCounted'))
	
	print('<boat data initiated>')

	
	#var file=FileAccess.open("user://boat_data.dat", FileAccess.WRITE)

	
	#(boats)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		test1()
	if Input.is_action_just_pressed("level_boost"):
		#('saving')
		save_boats()
func nameGenerate():
	var boat_name=''
	var choice=randi_range(1,3)
	if choice==1:
		boat_name='The '+name_ends.pick_random()
	elif choice==2:
		boat_name='The '+name_starts.pick_random()+' '+name_ends.pick_random()
	elif choice==3:
		boat_name=name_starts.pick_random()+' '+name_ends.pick_random()
	return boat_name
func boatGenerate():

		var condition=randi_range(1,15)
		var boat_trait=BoatTraitData.traitGenerate()
		
		var boat_name=nameGenerate()
	
		var boat_type=type_dictionary.keys().pick_random()
		var boat1=BoatClass.new(condition,boat_trait,boat_name,boat_type,false,0,0)
		
		return boat1
func test1():
	pass
#	for i in range(1,300):
#		boatGenerate()

func save_boats():
	var file=FileAccess.open("user://boat_data.dat", FileAccess.WRITE)
	var boat_dict={}
	for i in boats:
		var crew_list=[]
		for j in i.crew:
			crew_list.append(j.key)
		#('new crew list:  ',crew_list)
		boat_dict[i.get_boat_name()]={'condition':i.get_condition(),'health':i.get_health(),'trait':i.get_boat_trait(),'type':i.get_boat_type(),'crew':crew_list,'voyage':i.on_voyage,'total_time':i.total_time,'time_left':i.time_left}
	#('saving:       ',boat_dict)
	file.store_var(boat_dict,true)
	file.flush()
	file.close()
func load_boats():
	boats=[]
	#('loading_boats')
	var file = FileAccess.open("user://boat_data.dat", FileAccess.READ)
	var boat_dict=file.get_var(true)
	for i in boat_dict.keys():
		var new_boat=BoatClass.new(boat_dict[i]['condition'],boat_dict[i]['trait'],i,boat_dict[i]['type'],boat_dict[i]['voyage'],boat_dict[i]['total_time'],boat_dict[i]['time_left'])
		new_boat.set_health(boat_dict[i]['health'])
		#(boat_dict[i]['crew'], 'crew')
		for j in CrewData.employees:
			#(j.key)
			if j.key in boat_dict[i]['crew']:
				new_boat.add_crew(j)
		boats.append(new_boat)
