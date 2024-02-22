extends Node
# min depth,maxdepth, size , biome, max_support

var fish_stats={
	#open
	'Atlantic Cod':[[1,2],2,'open',400,3,120],
	'Common Squid':[[2,5],1,'open',1200,0.5,20],
	'Mackeral':[[1,2],2,'open',800,1,90],
	'Blueshark':[[1,2],3,'open',100,40,2500],
	'Yellowfin Tuna':[[1,1],3,'open',150,25,2000],
	'Common Shrimp':[[4,5],1,'open',1700,0.3,10],
	'Seabass':[[1,2],2,'open',300,6,300],
	#shallows
	'Edible Crab':[[1,1],1,'shallows',200,0.6,40],
	#kelp
	'Grouper':[[2,2],2,'kelp',300,7,180],
	'Goliath Grouper':[[2,3],3,'kelp',120,20,1700],
	'Kelp Fish':[[2,3],1,'kelp',500,4,30],
	'Kelp Crab':[[3,3],1,'kelp',900,0.5,25],
	'Decorator Crab':[[3,3],1,'kelp',700,0.8,30],
	#seagrass
	'Cuttlefish':[[2,2],1,'seagrass',200,0.5,25],
	'Crayfish':[[2,2],1,'seagrass',400,0.4,35],
	#depths
	'Angler Fish':[[4,7],2,'depths',400, 8,140],
	'Monkfish':[[5,8],2,'depths',800,6,500]
}
var biome_stats={
	'open':[5,2000,5],
	'kelp':[3,1000,2],
	'seagrass':[2,750,3],
	'shallows':[1,400,1],
	'depths':[8,3000,10]
}
var map={}
var inventory={'Mackeral':10}
var prices={}
signal fish_added(fish,amount)
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	ecosystem_generate('shallows',1,'the_shallows',1)
	ecosystem_generate('kelp',5,'kelp_forest',2)
	ecosystem_generate('seagrass',2,'seagrass_meadows',2)
	ecosystem_generate('open',7,'southern_waters',3)
	ecosystem_generate('open',6,'northern_waters',3)
	ecosystem_generate('open',5,'eastern_waters',3)
	ecosystem_generate('depths',2,'northern_depths',4)
	ecosystem_generate('depths',2,'eastern_depths',4)
	ecosystem_generate('depths',2,'western_depths',4)
	ecosystem_generate('depths',2,'southern_depths',4)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func tick():
	for i in map:
		map[i].tick()
	
				
func ecosystem_generate(biome,size,nm,dis):
	var levels=[]
	
	levels.append(Population.new(biome_stats[biome][0],biome_stats[biome][1]*(size/2.0),biome,0,0,0))
	levels[0].debug_display()
	levels=fish_select(biome,size,levels)
	levels.sort_custom(sort_size)
	for i in range(len(levels)):
		levels[i].trophic_place=i
	map[nm]=Ecosystem.new(levels,biome_stats[biome][0],size,dis,biome_stats[biome][2])

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
	#(count)
	var fish_list=fish_stats.keys()
	var species=fish_list.pick_random()
	if fish_stats[species][2]==biome:
		
		var dupe=false
		for i in levels:
			if i.get_species()==species:
				dupe=true
		if not dupe:
			levels.append(Population.new(fish_stats[species][0],fish_stats[species][3],species,fish_stats[species][1],0,fish_stats[species][4]))
			count-=1
	if count>0:
		fish_select(biome,count,levels)
	return levels
