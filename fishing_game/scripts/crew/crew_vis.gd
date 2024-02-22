extends Node3D
var blink_time=0

# Called when the node enters the scene tree for the first time.
func _ready():
	blink_time=randi_range(5,25)
	get_node('blink').wait_time=blink_time
	get_node('blink').start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_blink_timeout():
	get_node("AnimationPlayer").play('blink')
	blink_time=randi_range(5,25)
	get_node('blink').wait_time=blink_time
	get_node('blink').start()
	
func update_skin(crew_member):
	#('hair:   ',crew_member.hair)
	if crew_member.hair==0:
		get_node('hair').visible=false
	else:
	
		get_node('hair').visible=true
		get_node('hair').mesh=load(str("res://models/crewmates/hair/hair"+str(crew_member.hair)+".obj"))
		get_node('hair').set_surface_override_material(0,load(str("res://Textures/crew/hair"+str(crew_member.hair_colour)+".tres")))
	get_node('stache').mesh=load(str("res://models/crewmates/moustache/stache"+str(crew_member.moustache)+".obj"))
	get_node('stache').set_surface_override_material(0,load(str("res://Textures/crew/hair"+str(crew_member.hair_colour)+".tres")))
	get_node('brow').set_surface_override_material(0,load(str("res://Textures/crew/hair"+str(crew_member.hair_colour)+".tres")))
	get_node('hair').set_surface_override_material(0,load(str("res://Textures/crew/hair"+str(crew_member.hair_colour)+".tres")))
	get_node('head').set_surface_override_material(0,load(str("res://Textures/crew/skin"+str(crew_member.skin_colour)+".tres")))
	get_node('nose').set_surface_override_material(0,load(str("res://Textures/crew/skin"+str(crew_member.skin_colour)+".tres")))
