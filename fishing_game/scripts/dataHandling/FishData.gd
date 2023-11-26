extends Node
# depth, size , biome
var fish_stats={
	'cod':[1,2,'open',100],
	'squid':[2,1,'open',1000],
	'mackeral':[1,2,'open',700]
	
}
var biome_stats={
	'open':[5,2000],
	'kelp':[3,1000],
	'seagrass':[2,750],
	'shallows':[1,400]
}
var map=[]
# Called when the node enters the scene tree for the first time.
func _ready():
	map.append(ecosystem_generate('open',3))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ecosystem_generate(biome,size):
	var levels=[]
	
	levels.append(Population.new(biome_stats[biome][0],biome_stats[biome][1],biome,0,0))
	levels[0].debug_display()
	var count=size
	var fish_list=[]
	for i in fish_stats:
		fish_list.append(i)
	while count>0:
		var i = fish_list.pick_random()
		print(fish_stats[i][0])
		if biome == fish_stats[i][2]:
			count-=1
			levels.append(Population.new(fish_stats[i][0],fish_stats[i][3],i,fish_stats[i][1],0))
	levels.sort_custom(sort_size)
	for i in range(len(levels)):
		levels[i].trophic_place=i
		
	return Ecosystem.new(levels,biome_stats[biome][0],size)
func sort_size(a,b):
	if a.get_size()<b.get_size():
		return true
	elif a.get_size()==b.get_size():
		if a.get_max_support()>b.get_max_support():
			return true
		else:
			return false
	else:
		return false
