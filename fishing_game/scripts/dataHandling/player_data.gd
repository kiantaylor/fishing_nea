extends Node

var money=10000
var lvl=1
var xp_threshold=0.0
var xp=0
var boat_space=0
var boat_space_used=0
var selling_speed_boost=0.0
var tips_boost=0.0
var grass=false
var wind =false
var water=false
# Called when the node enters the scene tree for the first time.
func _ready():
	xp_threshold=(2**((lvl-20)/3)+1)*100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('money_boost'):
		money+=1000000
	if Input.is_action_just_pressed('level_boost'):
		level_up()
	lvl=BuildingData.build_map['light_house'][0][0]
	var total=0
	if len(BuildingData.build_map['harbour'])>0:
		for i in BuildingData.build_map['harbour']:
			total+=i[0]*2+14
	boat_space=total
	
func level_up():
	lvl+=1
	xp=0
	xp_threshold=int((2.0**((lvl-20.0)/3.0)+1.0)*100.0)
	#(xp_threshold)
func save_player_data():
	var file = FileAccess.open('user://player_data.dat',FileAccess.WRITE)
	var stat_dict={
		'money':money,
		'lvl':lvl,
		'boat_space':boat_space,
		'boat_space_used':boat_space_used,
		'grass':grass,
		'wind':wind
	}
	file.store_var(stat_dict)
	file.flush()
	file.close()
func load_player_data():
	var file = FileAccess.open('user://player_data.dat',FileAccess.READ)
	var stat_dict=file.get_var()
	money=stat_dict['money']
	lvl=stat_dict['lvl']
	boat_space=stat_dict['boat_space']
	boat_space_used=stat_dict['boat_space_used']
	grass=stat_dict['grass']
	wind=stat_dict['wind']
	file.close
