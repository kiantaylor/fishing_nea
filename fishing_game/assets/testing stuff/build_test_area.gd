extends Node3D

var ghost_present=false
var ghost
var ghost_type=''
var build_camera=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("camera_pivot/free_cam").current=not build_camera
	get_node("build_cam").current=build_camera


func _on_build_overlay_generate_ghost(building,relocating,ghost_position,ghost_rotation):
	print(building,ghost_type)
	if not ghost_present:
		var ghost_load=load(str("res://assets/buildings/build_ghosts/"+building+"_ghost.tscn"))
		var ghost_instance=ghost_load.instantiate()
		ghost=ghost_instance
		ghost_type=building
		print(ghost_type,'    ghost_type')
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



