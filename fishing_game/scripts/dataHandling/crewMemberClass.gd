extends Node


class_name CrewMemberClass
var speed_effect
var durability_effect
var morale_effect
var large_fish_effect
var medium_fish_effect
var small_fish_effect

var crew_type
var crew_trait
var salary:int
var experience:int

func _init(ct='skp',ctr=[],sal=100,exp=1):
	crew_type=ct
	crew_trait=ctr
	sal=sal
	experience=exp
	apply_trait()
	
	
func apply_trait():
	crew_trait[1]+=experience
	if crew_trait[0]==0:
		speed_effect=crew_trait[1]
	elif crew_trait[0]==1:
		durability_effect=crew_trait[1]
	elif crew_trait[0]==2:
		large_fish_effect=crew_trait[1]
	elif crew_trait[0]==3:
		medium_fish_effect=crew_trait[1]
	elif crew_trait[0]==4:
		small_fish_effect=crew_trait[1]
	elif crew_trait[0]==5:
		morale_effect=crew_trait[1]
	
