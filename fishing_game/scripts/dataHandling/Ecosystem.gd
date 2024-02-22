extends Node


class_name Ecosystem

var max_support
var levels=[]
var depth=0
var area=''
var size=500
var testarr=[]
var distance
var storm_rating
func _init(lv,d,s,dis,st):
	levels=lv
	depth=d
	storm_rating=st
	distance=dis
	size=s
	max_support=levels[0].get_max_support()
	for i in levels:
		i.set_mass(int(levels[i.trophic_place-1].max_support/1.5))
		#('mass start:  ',i.get_mass())
	initial_gen()
	for i in levels:
		i.debug_display()
func tick():
	for i in levels:
		feed(i)
		
		
func storm(strength):
	strength*=storm_rating
	for i in levels:
		if i.get_mass()>strength:
			i.set_mass(i.get_mass()-strength)
		else:
			i.set_mass(1)
func sum_mass(accum,item):
	return accum+item.get_mass()

func initial_gen():
	var total=levels.reduce(sum_mass,0)

	for i in levels:
		if i.trophic_place!=0:
			i.set_mass(int((i.get_mass()/float(total))*(levels[0].max_support*0.5)))
		

func feed(population):

	if population.get_max_support()>levels.slice(population.trophic_place+1).reduce(sum_mass,0):
	
		if population.trophic_place+1<=size:
		
			
				
			levels[population.trophic_place+1].set_mass(levels[population.trophic_place+1].get_mass()+population.get_max_support()*0.05)
func get_levels():
	return levels
