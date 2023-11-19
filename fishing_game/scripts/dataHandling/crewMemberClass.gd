extends Node


class_name CrewMemberClass


# Effect
var speed_effect=0
var durability_effect=0
var morale_effect=0
var large_fish_effect=0
var medium_fish_effect=0
var small_fish_effect=0

# Useful attributes
var crew_type
var crew_trait
var salary:int
var experience:int
var crew_name

func _init(ct='skp',ctr=[0,25],sal=100,exp=1,cn='erik'):
	crew_type=ct
	crew_trait=ctr
	#crew_type='coo'
	#crew_trait=[0,25]
	#crew_trait[1]=60
	experience=exp
	crew_name=cn
	salary=salary_calculate()
	
	
	apply_trait()
	#debug_stat_display()
func get_experience():
	return experience
func get_crew_type():
	return crew_type
func get_type_name():
	return CrewData.type_map[get_crew_type()]
func get_crew_name():
	return crew_name
func debug_stat_display():
	print('-----------------------------')	
	print('Stats for ',crew_name,' :')
	print('-----------------------------')
	print('Role : ',crew_type)
	print('Salary : ',salary)
	print('Trait code : ',crew_trait)
	print('Experience : ',experience)
	print('Speed effect: ',speed_effect)
	print('Durability effect: ',durability_effect)
	print('Medium fish effect: ',medium_fish_effect)
	print('small fish effect: ',small_fish_effect)
	print('large fish effect: ',large_fish_effect)
	print('Morale effect: ',morale_effect)

func salary_calculate():
	var strength=crew_trait[1]+experience
	
	return (strength)**randf_range(1.5,3.0)
func apply_trait():
	var strength=crew_trait[1]*((experience/8)+1)
	
	if crew_trait[0]==0:
		speed_effect=strength
	elif crew_trait[0]==1:
		durability_effect=strength
	elif crew_trait[0]==2:
		large_fish_effect=strength
	elif crew_trait[0]==3:
		medium_fish_effect=strength
	elif crew_trait[0]==4:
		small_fish_effect=strength
	elif crew_trait[0]==5:
		morale_effect=strength
		
	
