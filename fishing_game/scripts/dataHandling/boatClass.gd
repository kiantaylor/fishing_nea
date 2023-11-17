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
var base_small_fish
var small_fish
var base_medium_fish
var medium_fish
var base_large_fish
var large_fish
var crew=[]
var speed_boost=0
var durability_boost=0
var small_boost=0
var medium_boost=0
var large_boost=0
var morale=0

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
	base_small_fish=boat_management.type_dictionary[boat_type][5]
	base_medium_fish=boat_management.type_dictionary[boat_type][6]
	base_large_fish=boat_management.type_dictionary[boat_type][7]
	small_fish=base_small_fish
	medium_fish=base_medium_fish
	large_fish=base_large_fish
	crew_slots=boat_management.type_dictionary[boat_type][3]
	base_price=boat_management.type_dictionary[boat_type][4]
	if bt=='bt1':
		vis_name='boat_1_visual.tscn'
		dis_name='Testing Boat'
	price=calculate_cost(base_price,boat_trait)
	
	apply_condition()
	debug_stat_display()
	
	
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
	
func get_small():
	return small_fish
func get_medium():
	return medium_fish
func get_large():
	return large_fish
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
	print('Small : ',small_fish)
	print('Medium : ',medium_fish)
	print('Large : ',large_fish)
	
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
	if new_condition>=1.0 and new_condition<=15.0:
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
	var percentage_change = 1+(condition/10.0)
	speed=percentage_change*base_speed
	durability=percentage_change*base_durability
	small_fish=percentage_change*base_small_fish
	medium_fish=percentage_change*base_medium_fish
	large_fish=percentage_change*base_large_fish
	apply_trait(boat_trait)

func calculate_trait(trait1):
	print(trait1)
	if int(trait1[3])==1:
		var ratio_place=int(trait1[2])

		var ratio=BoatTraitData.engineering[ratio_place]
		trait_name=BoatTraitData.engineering_name[ratio_place]
		var percentage_change=int(trait1.substr(0,2))
		percentage_change*=condition/5.0
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
		percentage_change*=condition/5.0
		var small_change=percentage_change*ratio[0]
		
		var medium_change=percentage_change*ratio[1]
		var large_change=percentage_change*ratio[2]
		small_change/=100.0
		medium_change/=100.0
		large_change/=100.0
	
	
		return [small_change,medium_change,large_change]

func apply_trait(trait1):
	if len(calculate_trait(trait1))==2:

		var change_list=calculate_trait(trait1)
	
		speed+=change_list[0]*speed
		durability+=change_list[1]*durability
	else:

		var change_list=calculate_trait(trait1)
		if small_fish==0.0:
			small_fish+=change_list[0]*100
		
		else:
			
			small_fish+=change_list[0]*small_fish
		if medium_fish==0.0:
			medium_fish+=change_list[1]*100
		else:
			medium_fish+=change_list[1]*medium_fish
		if large_fish==0.0:
			large_fish+=change_list[2]*100
		else:
			large_fish+=change_list[2]*large_fish
	
func upgrade():
	if condition<15.0:
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

#crew members

func add_crew(crew_member):
	crew_member.debug_stat_display()
	var count=0
	for i in crew_slots:
		if i==crew_member.crew_type:
			count+=1
	var count2=0
	if len(crew)>0:
		for i in crew:
			if i.crew_type==crew_member.crew_type:
				count2+=1
	if count-count2>0:
		crew.append(crew_member)
		apply_crew(crew_member)
	
func apply_crew(crew_member):
	speed_boost+=(crew_member.speed_effect/100.0)+1
	durability_boost+=(crew_member.durability_effect/100.0)+1
	morale+=(crew_member.morale_effect/100.0)+1
	small_boost+=(crew_member.small_fish_effect/100.0)+1
	large_boost+=(crew_member.large_fish_effect/100.0)+1
	medium_boost+=(crew_member.medium_fish_effect/100.0)+1
	print(speed_boost,'   speed boost')
	print(durability_boost,'   durability boost')
	print(morale,'   morale boost')
	print(small_boost,'   small boost')
	print(medium_boost,'   medium boost')
	print(large_boost,'   large boost')
