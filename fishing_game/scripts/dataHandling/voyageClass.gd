extends Node


class_name VoyageClass

var boat
var fishing_zone
var target_fish_populations=[]
var target_fish_ratio=[]
var recurring=false

func _init(voyage_boat,voyage_fishing_zone,voyage_target_fish_populations,voyage_target_fish_ratio,voyage_recurring):
	boat=voyage_boat
	fishing_zone=voyage_fishing_zone
	target_fish_populations=voyage_target_fish_populations
	target_fish_ratio=voyage_target_fish_ratio
	recurring=voyage_recurring
