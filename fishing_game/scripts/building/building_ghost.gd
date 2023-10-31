extends Area3D
var colliding=false
var land=false
var relocation=false
signal corporate(building_name,build_rotation,build_position,relocation)
# Called when the node enters the scene tree for the first time.
func _ready():
	print(name)
	check()
	connect("corporate",get_parent().ghost_busted)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if land and not get_node("land_sense").is_colliding():
		for i in get_node("meshes").get_children():
			i.set_surface_override_material(0,load("res://Textures/buildings/ghosts/red_ghost.tres"))
		land=false
	if not land and  get_node("land_sense").is_colliding():
		for i in get_node("meshes").get_children():
			i.set_surface_override_material(0,load("res://Textures/buildings/ghosts/green_ghost.tres"))
		land=true
	if Input.is_action_pressed('build_up'):
		position.z-=0.1
	elif Input.is_action_pressed('build_down'):
		position.z+=0.1
	if Input.is_action_pressed('build_left'):
		position.x-=0.1
	elif Input.is_action_pressed('build_right'):
		position.x+=0.1
	if Input.is_action_pressed('build_rotate_left'):
		rotation.y-=0.1
	elif Input.is_action_pressed('build_rotate_right'):
		rotation.y+=0.1
	if Input.is_action_just_pressed("build_place") and land and not colliding:
		emit_signal('corporate',get_meta("building_type"),rotation,position,relocation)
		
		if not relocation:
			BuildingData.build_map[get_meta("building_type")].append([1,position,rotation])
			PlayerData.money-=BuildingData.build_requirements[get_meta("building_type")][0]
			PlayerData.xp+=10*BuildingData.build_requirements[get_meta("building_type")][1]
		else:
			for i in BuildingData.build_map[get_meta("building_type")]:
				if i==BuildingData.position_backup:
					i[1]=position
					i[2]=rotation
		print(BuildingData.build_map)
		queue_free()
	if Input.is_action_just_pressed('ui_cancel'):
		get_parent().ghost_present=false
		queue_free()


func _on_body_entered(body):
	print('hit')
	colliding=true
	for i in get_node("meshes").get_children():
		i.set_surface_override_material(0,load("res://Textures/buildings/ghosts/red_ghost.tres"))


func _on_body_exited(body):
	colliding=false
	check()
	for i in get_node("meshes").get_children():
		i.set_surface_override_material(0,load("res://Textures/buildings/ghosts/green_ghost.tres"))
func check():
	get_node("CollisionShape3D").disabled=true
	get_node("CollisionShape3D").disabled=false
