extends Node

class_name  BoatClass
var boat_management=BoatData
var condition_rating:int
var condition:float
var boat_name=''
var boat_trait=''
var boat_type=''
var speed:float
var base_speed:float
var size:int
var base_price=0
var price=0
var vis_name=''
var dis_name=''
var base_durability:float
var durability:float
var crew_slots=[]
var trait_name='fishing'

# class definition

func _init(cr=5,btr='xex',bn='steve',bt='bt1'):
	condition_rating=cr
	condition=float(cr)
	boat_name=bn
	boat_trait=btr	
	boat_type=bt
	size=boat_management.type_dictionary[boat_type][0]
	base_speed=boat_management.type_dictionary[boat_type][1]
	speed=base_speed
	base_durability=boat_management.type_dictionary[boat_type][2]
	durability=base_durability
	crew_slots=boat_management.type_dictionary[boat_type][3]
	base_price=boat_management.type_dictionary[boat_type][4]
	if bt=='bt1':
		vis_name='boat_1_visual.tscn'
		dis_name='Testing Boat'
	price=calculate_cost(base_price,boat_trait)
	apply_condition()
	apply_trait(boat_trait)
	
# get methods :

func get_condition():
	return(condition)
	
func get_condition_rating():
	return condition_rating

func get_boat_name():
	return boat_name
	
func get_boat_trait():
	return boat_trait
func get_size():
	return size
func get_boat_type():
	return boat_type
func get_speed():
	return speed
func get_durability():
	return durability
func get_stats():
	return [base_speed,speed,size,durability,crew_slots]

func debug_stat_display():
	print('-----------------------------')	
	print('Stats for ',boat_name,' :')
	print('-----------------------------')
	print('Type : ',boat_type)
	print('Price : ',price)
	print('Trait code : ',boat_trait)
	print('Condition : ',condition)
	print('Condition Rating : ',condition_rating)
	print('Size : ',size)
	print('Speed : ',speed)
	print('Durability : ',durability)
	print('Crew slots : ')
	var count=1
	for i in crew_slots:
		print('Slot ',count,' : ',i)
		
# set methods :

func rename(new_name):
	if len(new_name)<=30 and len(new_name)>=3:
		boat_name=new_name

		return true
	else:
		return false
	
func set_condition(new_condition):
	if new_condition>=1.0 and new_condition<=5.0:
		condition=new_condition
		if condition ==int(condition):
			condition_rating=int(condition)

		while condition-condition_rating>=1.0:
			
		
			condition_rating+=1
		while condition-condition_rating<=-1.0:
		
			condition_rating-=1
		return true
		
	else:
		return false



# traits and conditions

func apply_condition():
	var percentage_change = (0.1*(1.5**(condition)))+0.5
	speed=percentage_change*base_speed
	durability=percentage_change*base_speed

func calculate_trait(trait1):
	if int(trait1[3])==1:
		var ratio_place=int(trait1[2])

		var ratio=BoatTraitData.engineering[ratio_place]
		trait_name=BoatTraitData.engineering_name[ratio_place]
		var percentage_change=int(trait1.substr(0,2))

		var speed_change=percentage_change*ratio[0]
		var durability_change=percentage_change*ratio[1]
		speed_change/=100.0
		durability_change/=100.0
	
	
		return [speed_change,durability_change]
	else:
		var ratio_place=int(trait1[2])

		var ratio=BoatTraitData.fishing[ratio_place]
		trait_name=BoatTraitData.fishing_name[ratio_place]
		var percentage_change=int(trait1.substr(0,2))

		var small_change=percentage_change*ratio[0]
		var medium_change=percentage_change*ratio[2]
		var large_change=percentage_change*ratio[2]
		small_change/=100.0
		medium_change/=100.0
		large_change/=100.0
	
	
		return [small_change,medium_change,large_change]

func apply_trait(trait1):
	if calculate_trait(trait1):
		var change_list=calculate_trait(trait1)
	
		speed+=change_list[0]*speed
		durability+=change_list[1]*durability
	
func upgrade():
	set_condition(get_condition()+1.0)
	apply_condition()
#cost and pricing

func calculate_cost(price1,trait1):
	var con_mod=price1*(0.2*condition_rating)
	price1+=con_mod
	if calculate_trait(trait1):
		var trait_values=calculate_trait(trait1)
		var sum=0
		for i in trait_values:
			sum+=i
		var trait_mod=price1*sum	
		return int(price1+trait_mod)
	else:
		return price1
