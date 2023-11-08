extends Node

# speed, durability , large fish ,medium fish, small fish , morale / strength min ,strength max
var type_traits={
	'skp':[[1,1,1,1,1,0],[5,10]],
	'dek':[[0,0,1,1,1,0],[1,4]],
	'mte':[[1,1,1,1,1,0],[1,6]],
	'coo':[[0,0,0,0,0,1],[4,10]],
	'eng':[[1,1,0,0,0,0],[1,10]]
}

# Called when the node enters the scene tree for the first time.
#func _ready():
	#for i in range(10):
	#	crew_generate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func trait_generate(type):
	var trait_effect_list=type_traits[type][0]
	var pick=0
	var place=0
	while pick==0:
		place=randi_range(0,5)
		pick=trait_effect_list[place]
	
	var strength=randi_range(type_traits[type][1][0],type_traits[type][1][1])
	return [place,strength]
func crew_generate():
	var type=type_traits.keys()[randi_range(0,4)]
	var crew_trait=trait_generate(type)
	var experience=randi_range(1,5)
	var crew1=CrewMemberClass.new(type,crew_generate(),5,experience)
