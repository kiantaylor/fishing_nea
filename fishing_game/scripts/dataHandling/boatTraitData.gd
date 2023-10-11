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
var fishing=[]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func traitGenerate():
	var trait_str=''
	var choice=randf_range(0,190)
	
	var num=2.718**(0.04*choice-3)+1
	if len(str(int(num+1.0)))==1:
		trait_str+='0'
	trait_str+=str(int(num+1.0))
	choice=str(randi_range(0,9))
	
	trait_str+=choice
	choice=str(randi_range(1,2))
	
	trait_str+=choice

	return trait_str
