extends Node3D

var ghost_present=false
var ghost
var ghost_type=''
var build_camera=false
var menu_accessed=false
# Called when the node enters the scene tree for the first time.
func _ready():
	CrewData.load_crew()
	if BoatData.boats==[]:
		BoatData.load_boats()
	BuildingData.load_buildings()
	PlayerData.load_player_data()
	#(BuildingData.build_map)
	Chat.playing=true
	PlayerOverlay.playing=true
	Chat.main_placement()
	var load_grass=load('res://assets/testing stuff/grass.tscn')
	var load_rock1=load('res://assets/testing stuff/rock1.tscn')
	var load_rock2=load('res://assets/testing stuff/rock2.tscn')
	load_build_map()
	if PlayerData.grass:
		for i in range(200):
			for j in range(200):
				var ping=randi_range(1,1200)
				if ping<=100:
					var new_grass=load_grass.instantiate()
					new_grass.position=Vector3(j-72.0,randf_range(-0.18,-0.1),i-65.0)
					new_grass.rotation.y=randf_range(0,6.28)
					add_child(new_grass)
				elif ping==101:
					var new_grass=load_rock1.instantiate()
					new_grass.position=Vector3(j-72.0,-0.18,i-65.0)
					new_grass.rotation.y=randf_range(0,6.28)
					add_child(new_grass)
				elif ping==102:
					var new_grass=load_rock2.instantiate()
					new_grass.position=Vector3(j-72.0,-0.18,i-65.0)
					new_grass.rotation.y=randf_range(0,6.28)
					add_child(new_grass)
	BuildingData.editing=false
	BuildingData.accessing=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	BuildingData.ghost_present=ghost_present
	if not menu_accessed and not BuildingData.building_camera:
		get_node("camera_pivot/free_cam").current=not build_camera
		get_node("build_cam").current=build_camera

func load_build_map():
	for i in BuildingData.build_map:
		for building in BuildingData.build_map[i]:
			var build_load=load(str('res://assets/buildings/built/'+i+'.tscn'))
			var build_new=build_load.instantiate()
			build_new.position=building[1]
			build_new.rotation=building[2]
			if i=='market':
				build_new.stock=building[3]
			build_new.level=building[0]
			add_child(build_new)
func _on_build_overlay_generate_ghost(building,relocating,ghost_position,ghost_rotation):
	#(building,ghost_type)
	if not ghost_present:
		var ghost_load=load(str("res://assets/buildings/build_ghosts/"+building+"_ghost.tscn"))
		var ghost_instance=ghost_load.instantiate()
		ghost=ghost_instance
		ghost_type=building
		#(ghost_type,'    ghost_type')
		ghost_instance.relocation=relocating
		ghost_instance.position=ghost_position
		ghost_instance.rotation=ghost_rotation
		add_child(ghost_instance)
	elif building!=ghost_type:
		ghost.queue_free()
		ghost_present=false
		_on_build_overlay_generate_ghost(building,relocating,ghost_position,ghost_rotation)
	ghost_present=true
func ghost_busted(building_name,build_rotation,build_position,relocation):
	
	ghost_present=false
	var build_load=load(str("res://assets/buildings/built/"+building_name+".tscn"))
	var build_instance=build_load.instantiate()
	build_instance.rotation=build_rotation
	build_instance.position=build_position
	if relocation:
		BuildingData.selected_building=build_instance
		get_node("building_edit_overlay").movement=false
	add_child(build_instance)
	get_node("build_overlay").info_refresh()
	BuildingData.save_buildings()
	PlayerData.save_player_data()



