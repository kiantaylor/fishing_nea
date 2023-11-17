extends Node
# ratio order is speed:durability
var engineering=[
	[1.0,0.0],
	[0.9,0.1],
	[0.8,0.2],
	[0.7,0.3],
	[0.6,0.4],
	[0.5,0.5],
	[0.4,0.6],
	[0.3,0.7],
	[0.2,0.8],
	[0.1,0.9],
	[0.0,1.0]
]
# ratio oder is small,medium,large
var fishing=[
	[1.0,0.0,0.0],
	[0.0,1.0,0.0],
	[0.0,0.0,1.0],
	[0.5,0.5,0.0],
	[0.0,0.5,0.5],
	[0.5,0.0,0.5],
	[0.33,0.33,0.33],
	[0.5,0.25,0.25],
	[0.25,0.5,0.25],
	[0.25,0.25,0.5],
	[1.0,1.0,1.0]
]
var fishing_name=[
	'Delicate',
	'Hearty',
	'Beast Hunting',
	'Delectable',
	'Premium',
	'Absolutist',
	'Equal',
	'Generous',
	'Sensible',
	'Hungry',
	'Lucky'
]
var engineering_name=[
	'Swift',
	'Quick',
	'Speedy',
	'Roving',
	'Rambling',
	'Reliable',
	'Toughened',
	'Sturdy',
	'Armoured',
	'Tanky',
	'Juggernaught'
	
]
# Called when the node enters the scene tree for the first time.
func _ready():
	print('<boat trait data initiated>')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func traitGenerate():
	var trait_str=''
	var choice=randf_range(50,980)
	
	
	if len(str(int(choice+1.0)))==1:
		trait_str+='0'
	trait_str+=str(int(choice+1.0))
	choice=str(randi_range(0,9))
	
	trait_str+=choice
	choice=str(randi_range(1,2))
	
	trait_str+=choice

	return trait_str
