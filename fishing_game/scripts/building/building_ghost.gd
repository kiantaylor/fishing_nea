extends Area3D
var colliding=false
var land=false
var relocation=false
signal corporate(building_name,build_rotation,build_position,relocation)
# Called when the node enters the scene tree for the first time.
func _ready():
	#(name)
	check()
	connect("corporate",get_parent().ghost_busted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if land and not get_node("land_sense").is_colliding():
		for i in get_node("meshes").get_children():
			var mats=i.get_surface_override_material_count()
			for j in range(mats):
				i.set_surface_override_material(j,load("res://Textures/buildings/ghosts/red_ghost.tres"))
		land=false
	if not land and  get_node("land_sense").is_colliding():
		for i in get_node("meshes").get_children():
			var mats=i.get_surface_override_material_count()
			for j in range(mats):
				i.set_surface_override_material(j,load("res://Textures/buildings/ghosts/green_ghost.tres"))
		land=true
	if Input.is_action_pressed('build_up'):
		position.z-=0.5
	elif Input.is_action_pressed('build_down'):
		position.z+=0.5
	if Input.is_action_pressed('build_left'):
		position.x-=0.5
	elif Input.is_action_pressed('build_right'):
		position.x+=0.5
	if Input.is_action_pressed('build_rotate_left'):
		rotation.y-=0.1
	elif Input.is_action_pressed('build_rotate_right'):
		rotation.y+=0.1
	if Input.is_action_just_pressed("build_place") and land and not colliding:
		
		
		if not relocation:
			if get_meta("building_type")!= 'market':
				BuildingData.build_map[get_meta("building_type")].append([1,position,rotation])
			else:
				BuildingData.build_map[get_meta("building_type")].append([1,position,rotation,[]])
			PlayerData.money-=BuildingData.build_requirements[get_meta("building_type")][0]
			PlayerData.xp+=10*BuildingData.build_requirements[get_meta("building_type")][1]
		else:
			for i in BuildingData.build_map[get_meta("building_type")]:
				if i==BuildingData.position_backup:
					i[1]=position
					i[2]=rotation
		#(BuildingData.build_map)
		Chat.building_built(get_meta("building_type").capitalize())
		emit_signal('corporate',get_meta("building_type"),rotation,position,relocation)
		queue_free()
	if Input.is_action_just_pressed('ui_cancel'):
		if  relocation:
			for i in BuildingData.build_map[get_meta("building_type")]:
				if i==BuildingData.position_backup:
					position=i[1]
					rotation=i[2]
					emit_signal('corporate',get_meta("building_type"),rotation,position,relocation)
		get_parent().ghost_present=false
		queue_free()


func _on_body_entered(body):
	#('hit')
	colliding=true
	for i in get_node("meshes").get_children():
		var mats=i.get_surface_override_material_count()
		for j in range(mats):
			i.set_surface_override_material(j,load("res://Textures/buildings/ghosts/red_ghost.tres"))


func _on_body_exited(body):
	colliding=false
	check()
	for i in get_node("meshes").get_children():
		var mats=i.get_surface_override_material_count()
		for j in range(mats):
			i.set_surface_override_material(j,load("res://Textures/buildings/ghosts/green_ghost.tres"))
func check():
	get_node("CollisionShape3D").disabled=true
	get_node("CollisionShape3D").disabled=false
