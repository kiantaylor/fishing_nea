extends Node

class_name Population
var max=0.0
var mass=0.0
var foodLimit=0.0
var depth=[]
var max_support=0.0
var species
var support=0.0
var size=1
var trophic_place
# Called when the node enters the scene tree for the first time.
func _init(d,m_s,sp,si,place):

	
	depth=d
	max_support=m_s
	species=sp
	size=si
	trophic_place=place

func debug_display():
	print('')
	print('-------------------------------------------------------')
	print('stats for :  ',species,' at place ',str(trophic_place))
	print('-------------------------------------------------------')
	if size!=0:
		print('Size :  ',str(size))
		print('Mass :  ',str(mass))
	else:
		print('Producer')
	print('Depth :  ',depth)
	print('Max support :  ',str(max_support))
	print('Support :  ',str(support))
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_max_support():
	return max_support
func get_mass():
	if trophic_place==0:
		return 0
	else:
		return mass
func set_mass(new_mass):
	if trophic_place!=0:
		mass=new_mass
func get_size():
	return size
func get_species():
	return species
