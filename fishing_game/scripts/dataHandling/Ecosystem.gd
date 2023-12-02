extends Node


class_name Ecosystem

var max_support
var levels=[]
var depth=0
var size=500
func _init(lv,d,s):
	levels=lv
	depth=d
	size=s
	max_support=levels[0].get_max_support()
	for i in levels:
		i.set_mass(int(levels[i.trophic_place-1].max_support/1.5))
		print('mass start:  ',i.get_mass())
	initial_gen()
	for i in levels:
		i.debug_display()
func tick():
	for i in levels:
		feed(i)
		
		i.debug_display()
			
func sum_mass(accum,item):
	return accum+item.get_mass()

func initial_gen():
	var total=levels.reduce(sum_mass,0)

	for i in levels:
		if i.trophic_place!=0:
			i.set_mass(int((i.get_mass()/float(total))*(levels[0].max_support*0.5)))
			print('mass new:  ',i.get_mass())

func feed(population):
	if population.get_max_support()>levels.slice(population.trophic_place+1).reduce(sum_mass,0):
		
		if population.trophic_place+1<=size:
			print(population.species,'  :   ',population.get_max_support())
			levels[population.trophic_place+1].mass+=population.get_max_support()*0.05
