extends Node


class_name VoyageClass

var boat
var fishing_zone
var target_fish_populations=[]
var target_fish_ratio=[]
var recurring=false
var active=false
var time=0
var yield_mod=1.0
signal voyage_ended(boat,location)
signal voyage_started(boat,location)
func _init(voyage_boat,voyage_fishing_zone,voyage_recurring):
	boat=voyage_boat
	fishing_zone=voyage_fishing_zone
	
	connect('voyage_ended',VoyageData.voyage_ended)
	recurring=voyage_recurring
func get_boat():
	return boat
func get_zone():
	return fishing_zone
func set_zone(new_zone):
	fishing_zone=new_zone
	target_fish_populations=[]
	target_fish_ratio=[]
func get_ratio():
	return target_fish_ratio
func get_populations():
	return(target_fish_populations)
func add_population(new_population,value):
	if len(target_fish_populations)<3:
		target_fish_populations.append(new_population)
		target_fish_ratio.append(value)
func set_ratio(value,place):
	if value>target_fish_ratio[place]:
		if get_ratio().reduce(sum,0)<6:
			target_fish_ratio[place]=value
	else:
		target_fish_ratio[place]=value
#	if target_fish_ratio.reduce(sum,0) >6:
#		var count=0
#		for i in target_fish_ratio:
#			if count!=place and target_fish_ratio.reduce(sum,0) >6:
#				target_fish_ratio[count]-=1
#
#			count+=1
func remove_population(population):
	var place= target_fish_populations.find(population)
	target_fish_populations.remove_at(place)
	target_fish_ratio.remove_at(place)
func sum(accum,item):
	return accum+item
func activate():
	active=true
	print('shjould be emmitting here for start')
	emit_signal('voyage_start',boat.get_boat_name(),fishing_zone.capitalize())
	var speed=boat.get_speed()*boat.speed_boost
	time=(FishData.map[get_zone()].distance/speed+boat.get_size())*10
	print(time)
	boat.total_time=time
	boat.time_left=0
	boat.on_voyage=true
func tick():
	if active:
		print('tick  ',time)
		
		time-=1
		boat.time_left=boat.total_time-time
		if time<=0:
			active=false
			harvest(true)
func storm_hit(failure):
	recurring=false
	if failure:
		harvest(false)
	else:
		yield_mod=randf_range(0.2,0.6)
func harvest(success):
	var size=boat.get_size()
	var small=(boat.get_small()*boat.small_boost)/100
	var medium=(boat.get_medium()*boat.medium_boost)/100
	var large=(boat.get_large()*boat.large_boost)/100
	var harvest_ratio=[0,0,0]
	var count=0
	for i in target_fish_ratio:
		if success:
			var percent=i/get_ratio().reduce(sum,0)
			harvest_ratio[count]=size*percent
		
			var fish_size=get_populations()[count].get_size()
			if fish_size==1:
				harvest_ratio[count]+=(harvest_ratio[count]*small)
			elif fish_size==2:
				harvest_ratio[count]+=(harvest_ratio[count]*medium)
			elif fish_size==3:
				harvest_ratio[count]+=(harvest_ratio[count]*large)
			target_fish_populations[count].debug_display()
			var yield_mass=target_fish_populations[count].fished(harvest_ratio[count]*10)*yield_mod
			var yield_fish=int(yield_mass/target_fish_populations[count].size_per)*1
			target_fish_populations[count].debug_display()
			
			print(yield_fish,'    ',target_fish_populations[count].get_species())
			Chat.fish_added(target_fish_populations[count].get_species(),yield_fish)
			if target_fish_populations[count].get_species() in FishData.inventory.keys():
				FishData.inventory[target_fish_populations[count].get_species()]+=yield_fish
			else:
				FishData.inventory[target_fish_populations[count].get_species()]=yield_fish
	
			count+=1
	
	boat.on_voyage=false
	print(FishData.inventory)
	if recurring:
		emit_signal('voyage_end',boat.get_boat_name(),fishing_zone.capitalize())
		activate()
		
	else:
		print('should be emmitting here for end')
		VoyageData.voyage_ended(boat.get_boat_name(),fishing_zone.capitalize())
		
		VoyageData.current_voyages.remove_at(VoyageData.current_voyages.find(self))
	print(VoyageData.current_voyages)

