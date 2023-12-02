extends Node
# min depth,maxdepth, size , biome, max_support
var fish_stats={
	#open
	'cod':[[1,2],2,'open',400],
	'csq':[[2,5],1,'open',1200],
	'mck':[[1,2],2,'open',800],
	'bls':[[1,2],3,'open',100],
	'tun':[[1],3,'open',150],
	'csh':[[4,5],1,'open',1700],
	'sbs':[[1,2],2,'open',300],
	#shallows
	'ecr':[[1],1,'shallows',200],
	#kelp
	'grp':[[2],2,'kelp',300],
	'ggr':[[2],3,'kelp',80],
	'kfs':[[2,3],1,'kelp',500],
	'kcr':[[3],1,'kelp',900],
	'dcr':[[3],1,'kelp',700],
	#seagrass
	'cuf':[[2],1,'seagrass',200],
	'cra':[[2],1,'seagrass',400]
	
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

	for biome in biome_stats.keys():
		map.append(ecosystem_generate(biome,1))

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func tick():
	for i in map:
		i.tick()
func ecosystem_generate(biome,size):
	var levels=[]
	
	levels.append(Population.new(biome_stats[biome][0],biome_stats[biome][1]*(size/2.0),biome,0,0))
	levels[0].debug_display()
	levels=fish_select(biome,size,levels)
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
func fish_select(biome,count,levels):
	print(count)
	var fish_list=fish_stats.keys()
	var species=fish_list.pick_random()
	if fish_stats[species][2]==biome:
		
		var dupe=false
		for i in levels:
			if i.get_species()==species:
				dupe=true
		if not dupe:
			levels.append(Population.new(fish_stats[species][0],fish_stats[species][3],species,fish_stats[species][1],0))
			count-=1
	if count>0:
		fish_select(biome,count,levels)
	return levels
