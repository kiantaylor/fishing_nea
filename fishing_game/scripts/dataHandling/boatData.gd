extends Node

# order of attributes: size,speed,durability,crewslots,base price,small, medium, large>
var type_dictionary={
	'bt1':[3,5.0,8.0,['skp','dek'],650,0.0,15.0,0.0]
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
	print('<boat data initiated>')

	print(boats)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		test1()
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

		var condition=randi_range(1,5)
		var boat_trait=BoatTraitData.traitGenerate()
		
		var boat_name=nameGenerate()
		var boat_type='bt1'
		var boat1=BoatClass.new(condition,boat_trait,boat_name,boat_type)
		
		return boat1
func test1():
	pass
#	for i in range(1,300):
#		boatGenerate()
